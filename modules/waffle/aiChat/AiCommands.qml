import QtQuick
import qs.services
import qs.modules.common
import qs.modules.common.functions

QtObject {
    id: root

    readonly property string prefix: "/"

    readonly property var commands: [
        {
            name: "attach",
            description: Translation.tr("Attach a file. Only works with Gemini."),
            execute: args => {
                Ai.attachFile(args.join(" ").trim());
            }
        },
        {
            name: "model",
            description: Translation.tr("Choose model"),
            execute: args => {
                Ai.setModel(args[0]);
            }
        },
        {
            name: "tool",
            description: Translation.tr("Set the tool to use for the model."),
            execute: args => {
                if (args.length === 0 || args[0] === "get") {
                    Ai.addMessage(Translation.tr("Usage: %1tool TOOL_NAME").arg(root.prefix), Ai.interfaceRole);
                } else {
                    const tool = args[0];
                    if (Ai.setTool(tool))
                        Ai.addMessage(Translation.tr("Tool set to: %1").arg(tool), Ai.interfaceRole);
                }
            }
        },
        {
            name: "prompt",
            description: Translation.tr("Set the system prompt for the model."),
            execute: args => {
                if (args.length === 0 || args[0] === "get") {
                    Ai.printPrompt();
                    return;
                }
                Ai.loadPrompt(args.join(" ").trim());
            }
        },
        {
            name: "key",
            description: Translation.tr("Set API key"),
            execute: args => {
                if (args[0] === "get")
                    Ai.printApiKey();
                else
                    Ai.setApiKey(args[0]);
            }
        },
        {
            name: "save",
            description: Translation.tr("Save chat"),
            execute: args => {
                const name = args.join(" ");
                if (name.trim().length === 0) {
                    Ai.addMessage(Translation.tr("Usage: %1save CHAT_NAME").arg(root.prefix), Ai.interfaceRole);
                    return;
                }
                Ai.saveChat(name);
            }
        },
        {
            name: "load",
            description: Translation.tr("Load chat"),
            execute: args => {
                const name = args.join(" ");
                if (name.trim().length === 0) {
                    Ai.addMessage(Translation.tr("Usage: %1load CHAT_NAME").arg(root.prefix), Ai.interfaceRole);
                    return;
                }
                Ai.loadChat(name);
            }
        },
        {
            name: "clear",
            description: Translation.tr("Clear chat history"),
            execute: () => {
                Ai.clearMessages();
            }
        },
        {
            name: "temp",
            description: Translation.tr("Set temperature (randomness) of the model. Values range between 0 to 2 for Gemini, 0 to 1 for other models. Default is 0.5."),
            execute: args => {
                if (args.length === 0 || args[0] === "get")
                    Ai.printTemperature();
                else
                    Ai.setTemperature(parseFloat(args[0]));
            }
        },
        {
            name: "test",
            description: Translation.tr("Markdown test"),
            execute: () => {
                const fence = "```";
                Ai.addMessage([
                    "<think>",
                    "A longer think block to test revealing animation",
                    "</think>",
                    "## Markdown test",
                    "### Formatting",
                    "",
                    "- *Italic*, `Monospace`, **Bold**, [Link](https://example.com)",
                    "",
                    "### Table",
                    "",
                    "| Feature | Quickshell | AGS/Astal |",
                    "|---|---|---|",
                    "| UI Toolkit | Qt | Gtk3/Gtk4 |",
                    "| Language | QML | Js/Ts/Lua |",
                    "",
                    "### Code block",
                    "",
                    fence + "cpp",
                    "#include <iostream>",
                    "int main() {",
                    "    std::cout << \"Hello\";",
                    "}",
                    fence
                ].join("\n"), Ai.interfaceRole);
            }
        }
    ]

    function handle(inputText) {
        if (inputText.startsWith(root.prefix)) {
            const command = inputText.split(" ")[0].substring(1);
            const args = inputText.split(" ").slice(1);
            const match = root.commands.find(cmd => cmd.name === command);
            if (match)
                match.execute(args);
            else
                Ai.addMessage(Translation.tr("Unknown command: ") + command, Ai.interfaceRole);
            return;
        }
        if (Ai.apiKeysLoaded && !Ai.currentModelHasApiKey) {
            Ai.addApiKeyAdvice(Ai.getModel());
            return;
        }
        Ai.sendUserMessage(inputText);
    }

    function fuzzy(text, command, items, build) {
        const query = text.split(" ")[1] ?? "";
        const head = text.trim().split(" ").length === 1 ? `${root.prefix}${command} ` : "";
        const results = Fuzzy.go(query, items.map(item => ({
                    "name": Fuzzy.prepare(item),
                    "obj": item
                })), {
            "all": true,
            "key": "name"
        });
        return results.map(result => build(result.target, head));
    }

    function chatName(path) {
        return FileUtils.trimFileExt(FileUtils.fileNameForPath(path)).trim();
    }

    function suggest(text) {
        if (text.length === 0 || !text.startsWith(root.prefix))
            return [];
        if (text.startsWith(`${root.prefix}model`)) {
            return root.fuzzy(text, "model", Ai.modelList, (target, head) => ({
                        "name": head + target,
                        "displayName": `${Ai.models[target].name}`,
                        "description": `${Ai.models[target].description}`
                    }));
        }
        if (text.startsWith(`${root.prefix}prompt`)) {
            return root.fuzzy(text, "prompt", Ai.promptFiles, (target, head) => ({
                        "name": head + target,
                        "displayName": FileUtils.trimFileExt(FileUtils.fileNameForPath(target)),
                        "description": Translation.tr("Load prompt from %1").arg(target)
                    }));
        }
        if (text.startsWith(`${root.prefix}save`)) {
            return root.fuzzy(text, "save", Ai.savedChats, (target, head) => ({
                        "name": head + root.chatName(target),
                        "displayName": root.chatName(target),
                        "description": Translation.tr("Save chat to %1").arg(root.chatName(target))
                    }));
        }
        if (text.startsWith(`${root.prefix}load`)) {
            return root.fuzzy(text, "load", Ai.savedChats, (target, head) => ({
                        "name": head + root.chatName(target),
                        "displayName": root.chatName(target),
                        "description": Translation.tr("Load chat from %1").arg(target)
                    }));
        }
        if (text.startsWith(`${root.prefix}tool`)) {
            return root.fuzzy(text, "tool", Ai.availableTools, (target, head) => ({
                        "name": head + target,
                        "displayName": target,
                        "description": Ai.toolDescriptions[target]
                    }));
        }
        return root.commands.filter(cmd => cmd.name.startsWith(text.substring(1))).map(cmd => ({
                    "name": `${root.prefix}${cmd.name}`,
                    "description": `${cmd.description}`
                }));
    }
}
