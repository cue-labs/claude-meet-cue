# Claude meet CUE: A Self-Correcting AI Example 🤖 + 🛡️

This repository contains the code for our blog post, **[Guardrailing Intuition:
Towards Reliable AI](https://cue.dev/blog/guardrailing-intuition-towards-reliable-ai/)**.

It provides a hands-on environment to experience the self-correcting AI workflow
described in our full tutorial: **[Claude meet CUE](https://cue.dev/docs/claude-meet-cue/)**. We highly
recommend having the tutorial open as you explore this repository.

The goal is to demonstrate how combining the intuitive power of an AI assistant
with the logical precision of CUE creates robust, self-correcting systems that
are provably correct.

-----

## Prerequisites

Before you begin, make sure you have the following CLI tools installed:

* **Claude Code CLI**: Follow the [official installation
  instructions](https://code.claude.com/docs/en/getting-started).
* **CUE CLI**: Follow the [official installation
  instructions](https://cue.dev/docs/installing-cue/).
* **Go**: A recent version of the Go toolchain (not strictly necessary, but the
  example is Go-based).

-----

## 🚀 Get Started

First, set up your local environment by cloning the repository and starting the
AI assistant.

**1. Clone the Repository**

```bash
git clone https://github.com/cue-labs/claude-meet-cue.git
cd claude-meet-cue
```

**2. Start the AI Assistant**

```bash
claude
```

The assistant will automatically detect and use the hook configuration in the
`.claude/` directory. You are now ready to run the experiments described in the
guide.

-----

## ✨ Try It Yourself

You're all set! With the `claude` assistant running, you can now replicate the
scenarios from our tutorial to see the CUE-powered guardrails in action.

Follow the steps in the **[Claude meet CUE
tutorial](https://cue.dev/docs/claude-meet-cue/)** to:

* **Challenge the AI's "memory"** to see why conversational promises aren't
  enough.
* **Prompt Claude** to make a valid change and see the CUE hook run
  successfully.
* **Trigger the magic moment**: Manually break the configuration, ask Claude for
  an unrelated change, and watch as it uses CUE's precise feedback to fix your
  original error!

-----

## 💡 How It Works

This self-correcting behavior is enabled by the files in the `.claude/`
directory. The `settings.json` file registers a hook that runs our CUE
validation script after every file edit. This script provides the structured,
logical feedback needed for Claude to understand and correct its own mistakes.

Enjoy the experiment!
