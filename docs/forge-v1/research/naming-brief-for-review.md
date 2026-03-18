# Forge Rename — Naming Brief for External Review

**Date:** 2026-03-18
**Status:** Open — seeking input from multiple LLMs and stakeholders
**Current placeholder:** "Forge" (the existing name, will be replaced)

---

## What This Project Is

Forge is a structured operating mode for AI-assisted software development. It gives coding agents risk-scaled workflows, evidence-gated completion, and durable project memory. Think of it as a **Principal Engineer that orchestrates your AI coding agents** — it ensures the right amount of ceremony happens for each task, every claim of completion is backed by evidence, and project context survives across sessions.

**Key characteristics:**
- Orchestrates multiple specialist AI agents (backend, frontend, QA, security reviewer, etc.)
- Enforces TDD (tests before code)
- Risk-scales ceremony (trivial tasks get minimal process, critical tasks get security review + rollback plans)
- Evidence-gated completion (agents must prove they're done, not just claim it)
- Team-first (shared conventions, policies, audit trails via git)
- Works as a plugin for Claude Code, Cursor, Codex CLI, and other AI coding tools
- The primary audience is **engineering teams**, not individual hobbyists

## What the Name Needs to Convey

The founder's words: *"When I say Prime, it carries a weight of 'this is the primary, the leader.' Whatever we use should sound like that in my head."*

**Must have:**
1. **Instant authority** — hearing the name should convey "this is THE one in charge"
2. **Weight/gravitas** — not cute, not clever, not manufactured. Feels like it already means something important.
3. **Short** — 1-3 syllables max. Must work as a CLI command (`<name> build`, `<name> plan`)
4. **Clean namespace** — no major conflicts on GitHub, npm, PyPI
5. **Not overused in tech** — no word that's already been claimed by a well-known tool/product

**Nice to have:**
- Evokes leadership, orchestration, principal engineering
- Works for a product that teams rally behind (not just a tool name)
- Has a story or etymology that's compelling once explained
- Sounds like it could be a real word (not a portmanteau or mashup)

**Explicitly rejected vibes:**
- Energy drink / startup name (Delvex, Corvex, Synthex)
- Fantasy game character (Voryn, Sovyn, Runis)
- Too cute or too clever
- Anything that requires constant spelling correction

## Names Already Rejected (with reasons)

### Rejected — Major namespace conflicts
| Name | Conflict |
|------|---------|
| Prime | Amazon Prime |
| Apex | Oracle, Salesforce, Apex Legends |
| Pantheon | Web hosting platform, widely overused |
| Arken | Active GitHub org + npm package |
| Archon | 1,117+ GitHub repos, multiple AI dev tools in same niche |
| Arxon | Too close to Archon (indistinguishable spoken aloud) |
| Helm | Kubernetes Helm |
| Axiom | Axiom Inc. observability company |
| Cato | Cato Networks enterprise security |
| Crux | Red Badger Crux framework (~1,500 stars) |
| Bastion | Infrastructure term (bastion host) + multiple products |
| Crucible | Atlassian Crucible brand ghost |
| Kovan | Ethereum testnet name |
| Ordis | Warframe character + npm package |
| Nexar | Altium-backed commercial brand |
| Kairos | Active AI "development supervisor" tool in same niche |
| Kairn | Active AI MCP tooling project in same space |
| Ferox | feroxbuster (7,600 stars) owns the prefix |
| Oberon | Wirth's programming language |
| Mycroft | Mycroft AI voice assistant brand ghost (shut down 2023) |
| Lodestar | ChainSafe Lodestar Ethereum client |
| Primo | Ex Libris Primo (university library software) |
| Orin | NVIDIA Jetson Orin hardware platform |

### Rejected — Sound/feel wrong
| Name | Reason |
|------|--------|
| Duxon, Duxar, Ordax, Praex | "Don't sound right" — too constructed |
| Delvex, Corvex, Praxen, Synthar, etc. | "Nothing has the weight this needs" — sound manufactured |
| Sentar, Corven, Provyn, Torven | Functional but lack gravitas |
| Mandex, Zelvex, Cortyn | Too much like product names |
| Mandate | Politically loaded post-2020 |
| Tribune | Newspaper association |

## Current Best Candidates

### Tier 1: Strongest options (but each has a catch)

#### Princeps
- **Origin:** Latin — "first citizen." The title Augustus chose to rule the Roman Empire. The etymological root of "principal," "prince," and by extension "prime."
- **Pronunciation:** PRIN-ceps (2 syllables)
- **CLI test:** `princeps build`, `princeps plan`, `princeps review`
- **Namespace:** Pristine — nothing found on npm, PyPI, or GitHub
- **Pros:**
  - Literally the ancestor word of "Prime" — carries the exact same meaning
  - Maximum historical gravitas
  - Completely clean namespace (rarest quality in this search)
  - The tagline writes itself: "The principal engineer for your codebase"
  - Implies *primus inter pares* (first among equals) — a Principal Engineer, not a dictator
- **Cons:**
  - Founder says "doesn't sound nice to me"
  - Requires pronunciation knowledge — not everyone will get it instantly
  - Might feel academic/pretentious to some
  - 2 syllables but the consonant cluster (-ceps) is unusual in English

#### Virgil
- **Origin:** Dante's *Divine Comedy* (1321). Virgil is the guide who leads Dante through Hell and Purgatory. Represents reason, judgment, protection.
- **Pronunciation:** VUR-jil (2 syllables)
- **CLI test:** `virgil build`, `virgil plan`, `virgil review`
- **Namespace:** Moderate conflict — VirgilSecurity owns npm namespace (`virgil-cli`, `virgil-sdk`, `virgil-crypto`)
- **Pros:**
  - Perfect metaphor: the guide through dangerous territory who ensures you survive
  - Supervised autonomy incarnate: Virgil can't enter Paradise (the human decides the final destination)
  - Immediately recognizable, easy to pronounce
  - Literary weight without being obscure
- **Cons:**
  - VirgilSecurity has claimed the developer namespace effectively
  - It's a personal name (Virgil Abloh, Virgil the poet) — might feel odd as a tool
  - Might be perceived as "another word someone grabbed from literature"
  - Very unlikely to be usable due to namespace conflicts

### Tier 2: Worth considering

#### Hegemon
- **Origin:** Greek — "the leader, the one who goes before." Root of "hegemony."
- **CLI test:** `hegemon build`, `hegemon plan`
- **Namespace:** Low conflict (one inactive Rust system monitor)
- **Pros:** Strong authority, clean namespace, 3 syllables but punchy
- **Cons:** "Hegemony" carries political/imperial baggage for some audiences

#### Suzerain
- **Origin:** Medieval French — a sovereign who works through vassals/agents, retaining ultimate authority
- **CLI test:** `suzerain build`, `suzerain plan`
- **Namespace:** Near-pristine
- **Pros:** Perfect conceptual fit for an orchestrator that delegates to agents. Elegant, distinctive.
- **Cons:** 3 syllables, might feel pretentious, not instant recognition

#### Straton
- **Origin:** Invented — stratum (layers/foundation) + archon (ruler). Sounds ancient Greek.
- **CLI test:** `straton build`, `straton plan`
- **Namespace:** Pristine
- **Pros:** Best invented word found. Sounds like a real ancient title. Zero conflicts.
- **Cons:** No inherent meaning people already know. Requires explanation.

#### Imperator
- **Origin:** Latin — "commander," root of "emperor." Caesar's troops shouted it after victories.
- **CLI test:** `imperator build`, `imperator plan`
- **Namespace:** Low conflict (gaming associations only)
- **Pros:** Unambiguous about authority. Extremely weighty.
- **Cons:** 4 syllables (too long for CLI?), might feel theatrical/overwrought, gaming associations

### Tier 3: Unexplored directions

#### Compound words (under exploration)
- Arkwright (historical craftsman)
- [Something]-Forge compounds
- "-wright" suffix compounds (archwright, codewright)
- Concept compounds (Ironclad, Stalwart)

## Final Shortlist (after 4 rounds, ~120 candidates evaluated)

### 1. Arkwright (Top Pick)
- **Origin:** Richard Arkwright — father of the industrial revolution. Built the water frame and the factory system. Didn't just make things — **built the process that made things at scale.**
- **CLI:** `arkwright build`, `arkwright plan`, `arkwright review`
- **Namespace:** Mostly clean. npm has a v0.0.2 abandoned scaffold. PyPI and crates.io clear. GitHub username taken by individual (not an org/product). The Arkwright Group is a European consulting firm (non-software).
- **Pros:** Real historical weight. The story maps perfectly: "built the system, not just the product." 2 syllables. Distinctive.
- **Cons:** Obscure outside UK/history buffs. Requires explanation. 9 characters to type.

### 2. Charter
- **Origin:** English — "a founding document that establishes rules, rights, and principles." The Magna Carta was a charter. Corporate charters define how organizations operate.
- **CLI:** `charter build`, `charter plan`, `charter review`
- **Namespace:** Cleanest real word found. PyPI is completely clear (404). npm has only a dead 2013 charting artifact. No major GitHub project.
- **Pros:** Everyone knows the word instantly. "Establishes the rules" is a perfect semantic fit. Codex-tier naming energy (simple word everyone knows, maps to what the tool does). Short (7 chars).
- **Cons:** Less "leader" energy than "Prime" — more about documents than authority. Could feel corporate.

### 3. Princeps
- **Origin:** Latin — "first citizen." Augustus's title for ruling Rome. The etymological root of "principal," "prince," and "prime."
- **CLI:** `princeps build`, `princeps plan`
- **Namespace:** Pristine — nothing on npm, PyPI, or GitHub.
- **Pros:** Literally the ancestor word of "Prime." Maximum historical gravitas. Completely clean namespace. Tagline: "The principal engineer for your codebase."
- **Cons:** Founder says "doesn't sound nice." Pronunciation (-ceps) is unusual in English. May feel academic.

### 4. Boole
- **Origin:** George Boole — inventor of boolean logic, the mathematical foundation of all computing.
- **CLI:** `boole build`, `boole plan`
- **Namespace:** npm package is tiny/unmaintained. PyPI is clear. BooleBox is an Italian enterprise product (non-dev-tools).
- **Pros:** Everyone in computing knows "boolean." 1 syllable. Foundational. The man who made logic formal.
- **Cons:** Marginal namespace conflicts. "Boole" sounds like "bool" — might feel like a type declaration, not a product.

### 5. Archwright (Fallback)
- **Origin:** Invented compound — arch (chief) + wright (maker/builder). "The chief builder."
- **CLI:** `archwright build`, `archwright plan`
- **Namespace:** Completely pristine — all registries 404, no GitHub presence. Domain taken by a Massachusetts custom home builder.
- **Pros:** Zero conflicts. Transparent meaning. "-wright" suffix has English precedent (playwright, shipwright).
- **Cons:** Invented word requires building meaning from scratch. Phonetically dense (two consonant clusters).

## CLI / Command Namespace Options

Brand name and CLI command don't have to be the same (Kubernetes → `kubectl`, Terraform → `tf`). Here are shorthand options for each candidate:

### Arkwright
| CLI Command | Chars | Feel | Conflicts / Notes |
|-------------|-------|------|-------------------|
| `arkwright` | 9 | Full name, authoritative but long | — |
| `ark` | 3 | Punchy, fast to type | ark.io blockchain, ARK npm package, Ark game. But distinctive in dev orchestrator space. |
| `arw` | 3 | Abbreviation | Awkward to say/type |
| `wright` | 6 | "The maker" — standalone meaning | Common surname, Wright brothers association |
| `aw` | 2 | Too short | Collides with `awk` mentally |

**Recommendation:** `ark` as CLI, "Arkwright" as brand. `ark build`, `ark plan`, `ark review` — clean, fast, memorable.

### Charter
| CLI Command | Chars | Feel | Conflicts / Notes |
|-------------|-------|------|-------------------|
| `charter` | 7 | Already reasonable length | — |
| `cht` | 3 | Abbreviation | Cryptic, looks like "chat" mistyped |
| `chtr` | 4 | Abbreviation | Unusual but learnable |

**Recommendation:** `charter` as-is. 7 chars is fine (same length as `docker`).

### Princeps
| CLI Command | Chars | Feel | Conflicts / Notes |
|-------------|-------|------|-------------------|
| `princeps` | 8 | Full name | — |
| `prin` | 4 | Short | Sounds like "print" — confusing |
| `pcps` | 4 | Abbreviation | Unpronounceable |
| `prn` | 3 | Abbreviation | Printer port on Windows (PRN is reserved!) |

**Recommendation:** `princeps` as-is. No good shorthand exists.

### Boole
| CLI Command | Chars | Feel | Conflicts / Notes |
|-------------|-------|------|-------------------|
| `boole` | 5 | Already short | — |
| `bool` | 4 | Shorter | Literally a type keyword in every language — highly confusing |

**Recommendation:** `boole` as-is. Already short enough.

### Archwright
| CLI Command | Chars | Feel | Conflicts / Notes |
|-------------|-------|------|-------------------|
| `archwright` | 10 | Too long for daily CLI use | — |
| `arch` | 4 | Clean, short | Arch Linux is a major conflict |
| `arw` | 3 | Abbreviation | Awkward |
| `aw` | 2 | Too short | — |

**Recommendation:** `arch` would be ideal but Arch Linux blocks it. No great shorthand.

### Summary: CLI Viability

| Brand | Best CLI | Chars | CLI Sentence | Verdict |
|-------|----------|-------|-------------|---------|
| **Arkwright** | `ark` | 3 | `ark build`, `ark plan`, `ark review` | Excellent — fast, memorable, punchy |
| **Charter** | `charter` | 7 | `charter build`, `charter plan` | Good — same length as `docker` |
| **Princeps** | `princeps` | 8 | `princeps build`, `princeps plan` | OK — no good shorthand |
| **Boole** | `boole` | 5 | `boole build`, `boole plan` | Good — already short |
| **Archwright** | `archwright` | 10 | `archwright build` | Weak — too long, no clean shorthand |

**Note:** If `ark` is chosen as the CLI command, need to verify the `ark` npm/PyPI/crates.io packages. The ark.io blockchain has `@arkecosystem/` scoped packages on npm but the unscoped `ark` package status should be confirmed.

---

## What Was Eliminated (and Why)

### Categories explored:
- **Latin/Greek roots** (Archon, Arxon, Princeps, Praex, etc.) — either taken or sound manufactured
- **Invented portmanteaus** (Delvex, Corvex, Synthex, etc.) — lack gravitas, sound like energy drinks
- **Mythology** (Aethon, Mimir, Tychon, etc.) — overused in tech
- **Public domain fiction** (Virgil, Mycroft, Prospero, Oberon, etc.) — namespace conflicts
- **Historical titles** (Tribune, Prefect, Regent, etc.) — either taken or wrong connotations
- **Concept words** (Axiom, Crux, Bastion, Crucible, etc.) — all taken by major projects
- **Scientist names** (Turing, Volta, Dirac, Planck, etc.) — fully saturated by funded companies
- **Industrial revolution figures** (Brunel, Whitworth, etc.) — didn't resonate with founder

### The fundamental tension:
Every word with instant "Prime" energy is already claimed in tech. Every clean word requires explanation. The shortlist above represents the best surviving options across ~120 candidates.

## What We're Looking For From Reviewers

1. **React to the shortlist** — does any of them have the "Prime" energy? Or are they all missing something?
2. **Suggest names we haven't considered** — especially from:
   - Public domain fiction (pre-1928 US copyright)
   - Non-Western language roots
   - Compound words or neologisms
   - Simple English words we may have overlooked
3. **Help us articulate what's missing** — what quality does "Prime" have that none of our candidates capture? Is it the vowel sound? The meaning? The cultural weight? Understanding this might unlock the right answer.
4. **Consider the "Codex pattern"** — the most successful AI tool names are simple English words everyone knows (Cursor, Copilot, Aider, Augment, Codex). Is there a simple word we've missed?

## Constraints Summary

- Must work as a CLI command (short, typeable)
- Must have clean namespace (GitHub, npm, PyPI, crates.io)
- Must carry "this is THE leader" energy — or failing that, strong authority/standards energy
- Must not sound manufactured or cute
- Target audience: engineering teams (not hobbyists)
- The tool is an orchestrator that manages AI coding agents with risk-scaled workflows, TDD enforcement, and evidence-gated completion
- Plugin-first architecture (Claude Code, Cursor, etc.) with future standalone CLI

## Research Artifacts

All naming research is documented in:
- `naming-research.md` — Round 1 (20 candidates, conflict checks)
- `naming-research-round2.md` — Round 2 (25 candidates + 15 brainstormed)
- `naming-research-round3.md` — Round 3 (20 candidates, public domain fiction + titles)
- `naming-research-round4.md` — Round 4 (25 role/concept/craft words)
- `naming-research-round4-focused.md` — Focused check on Arkwright, Precept, Percept, Karyon
- `naming-research-final.md` — Iconic scientist names (15 checked, all taken)
</content>
</invoke>