# Naming Research — Round 4

**Research date:** 2026-03-18
**Scope:** 25 candidates across role/relationship words, concept/principle words, craft/maker words, and structural words
**Methodology:** npm registry API, PyPI JSON API, GitHub direct page and topic checks

---

## Scoring Criteria

- **Conflicts found:** existing packages/repos that would create confusion or legal risk
- **Codex energy (1–5):** Does it feel like a breakout product name? (5 = Codex/Cursor/Aider tier)
- **CLI feel (1–5):** Does it sound natural as a command you type? (5 = you'd run `arbiter run` without blinking)
- **Instantly understood:** Does a dev immediately grasp the concept without explanation?

---

## Role / Relationship Words

### 1. Marshal

| Platform | Finding |
|----------|---------|
| npm | `marshal` exists — Ruby Marshal format parser, v0.5.4. Low use, niche. |
| PyPI | 404 — not registered |
| GitHub | 121 repos on "marshal" topic, mostly data serialization (Go, Python). No major AI/dev tool. |

**Conflicts:** Low. npm package is niche and unmaintained-ish. No major tool owns this name.
**Codex energy:** 3/5 — Strong military/legal authority feel, but "marshaling data" is a very common software term that dilutes it. Could be confused with serialization concepts.
**CLI feel:** 4/5 — `marshal run`, `marshal watch` — works naturally.
**Instantly understood:** Yes — organizer, director, one who brings order.

---

### 2. Warden

| Platform | Finding |
|----------|---------|
| npm | `warden` exists — Panopticon monitoring wrapper, v0.1.1. Abandoned. |
| PyPI | `warden` exists — Python app monitoring tool, v0.0.1a. Very old. |
| GitHub | **wardenenv/warden** — 458 stars, active CLI for Docker dev environments. **agentic-warden** — AI CLI management platform (Rust, 10 stars). |

**Conflicts:** Moderate-high. `wardenenv/warden` is an active, starred CLI tool. The Docker dev environment overlap is direct enough to cause confusion.
**Codex energy:** 3/5 — Guardian energy is right, but "warden" evokes prisons more than excellence.
**CLI feel:** 4/5 — Natural command verb feel.
**Instantly understood:** Yes — guardian, protector of standards.

---

### 3. Prefect

| Platform | Finding |
|----------|---------|
| npm | `prefect` exists — Node.js cluster manager, v0.0.5 (2017, abandoned). |
| PyPI | **Major conflict.** `prefect` is Prefect v3.6.22 — a 21,900-star workflow orchestration platform with commercial backing (Prefect Technologies, Inc.). |
| GitHub | PrefectHQ/prefect — 21.9k stars, 762 releases, 415 contributors. Dominant occupant. |

**Conflicts:** CRITICAL. Prefect is one of the most prominent Python orchestration platforms. This name is fully taken.
**Codex energy:** 4/5 — Would have been excellent. Latin origin, authority, precision.
**CLI feel:** 4/5
**Instantly understood:** Yes.
**VERDICT: ELIMINATED — hard conflict.**

---

### 4. Proctor

| Platform | Finding |
|----------|---------|
| npm | `proctor` exists — JS file watcher ("watch over your javascripts"), v0.0.4 (2014, abandoned). |
| PyPI | `proctor` exists — Python test runner, v1.5. Production/Stable, by Doug Hellmann. CLI tool with `proctorbatch` command. |
| GitHub | Multiple repos. PyPI package has CLI. |

**Conflicts:** Moderate. PyPI package is a real test runner with a CLI. The "supervises/examines" meaning maps almost too directly to testing rather than orchestration.
**Codex energy:** 2/5 — Sounds like a test proctor. Academic, slightly bureaucratic.
**CLI feel:** 3/5 — `proctor run` is odd; proctors don't run things.
**Instantly understood:** Yes, but maps to exam oversight not code orchestration.

---

### 5. Regent

| Platform | Finding |
|----------|---------|
| npm | `regent` exists — v3.6.0, maintained by Northwestern Mutual. Actively used JavaScript rules engine. |
| PyPI | `regent` exists — v0.1.0, framework for privileged system tasks. Active (2022). |
| GitHub | Multiple repos. npm package is actively maintained by a large company. |

**Conflicts:** Moderate. npm `regent` is a live, maintained business rules engine from Northwestern Mutual — not trivially displaced.
**Codex energy:** 3/5 — "One who governs in another's absence" is an interesting framing, but regent feels more regal than technical.
**CLI feel:** 3/5
**Instantly understood:** Somewhat — governs, but the "absence" connotation is odd for an active tool.

---

### 6. Steward

| Platform | Finding |
|----------|---------|
| npm | `steward` exists — desktop monitoring tool, v0.1.4. Niche. |
| PyPI | `steward` exists — Python serialization library, v0.0.4 (2012, very old). |
| GitHub | `OmniSteward` (112 stars, LLM agent butler). Two repos tagged "steward" explicitly about AI governance. Multiple active uses. |

**Conflicts:** Low-moderate. The existing packages are old/niche. However, "steward" is increasingly used in the AI governance space (two GitHub repos explicitly about AI stewardship).
**Codex energy:** 3/5 — "Manages on behalf of another" is a perfect semantic fit, but steward feels mild and domestic (flight steward, ship steward).
**CLI feel:** 3/5 — `steward run` is a bit soft.
**Instantly understood:** Yes — caretaker, manager.

---

### 7. Captain

| Platform | Finding |
|----------|---------|
| npm | `captain` exists — v0.2.4, CLI command coordinator tool. Actually overlaps in concept. |
| PyPI | `captain` exists — v6.1.0, actively maintained Python CLI framework. Real conflict. |
| GitHub | caprover/caprover (12k+ stars, "Captain Duckworth" PaaS). Multiple captain-themed dev tools. |

**Conflicts:** HIGH. PyPI `captain` is an active, well-maintained CLI framework at v6.1.0. CAPRover (previously "Captain") is a major self-hosting PaaS with 12k+ stars.
**Codex energy:** 2/5 — Too common and too playful. "Captain" is also a Salesforce product tier name.
**CLI feel:** 4/5
**Instantly understood:** Yes, but overused.
**VERDICT: ELIMINATED — hard conflicts.**

---

### 8. Arbiter

| Platform | Finding |
|----------|---------|
| npm | `arbiter` exists — Salesforce ORM, v2.0.2. Niche/enterprise. |
| PyPI | `arbiter` exists — lightweight data flow framework, v1.1.2 (2021). Low use. |
| GitHub | `heurema/arbiter` — AI orchestrator with claude-code topic (13 days old, 1 star). `imjustsergy/arbiter-tui` — "Terminal orchestrator for AI coding agents." `amangupta05/ArbiterAI` — LLM multi-agent negotiation. The AI orchestration space is already using this word. |

**Conflicts:** Moderate-high. Multiple AI orchestration projects on GitHub are already using "Arbiter." The AI-native usage is spreading fast — this name is being colonized.
**Codex energy:** 4/5 — Decision-maker, final authority. This has strong product energy.
**CLI feel:** 4/5 — `arbiter run`, `arbiter check` — excellent.
**Instantly understood:** Yes — final decision-maker, authority.
**NOTE:** High Codex energy but the AI-tools space is already claiming it organically.

---

### 9. Patron

| Platform | Finding |
|----------|---------|
| npm | `patron` exists — v4.0.0, Discord.js command framework. Active. |
| PyPI | `patron` exists — v0.0.1, placeholder by hsluoyz/openstackci. |
| GitHub | Multiple Discord bot frameworks. |

**Conflicts:** Moderate. npm `patron` is a maintained Discord bot framework. "Patron" also has a strong association with Patreon (the platform), causing brand confusion.
**Codex energy:** 2/5 — Patron sounds like a sponsor, not a tool. Patreon association is distracting.
**CLI feel:** 2/5
**Instantly understood:** Yes, but in the wrong direction (financial patron, not technical authority).

---

### 10. Rector

| Platform | Finding |
|----------|---------|
| npm | `rector` exists — v0.0.35, minimal package from 2016. Effectively abandoned. |
| PyPI | `rector` exists — v0.1.9, regex generator CLI. Recent (2024), active. |
| GitHub | **rectorphp/rector** — 8,300+ stars. Major PHP static analysis and refactoring tool. Extremely prominent in the PHP ecosystem. |

**Conflicts:** HIGH. Rector PHP is an 8k-star tool that any PHP developer knows. Serious brand conflict.
**Codex energy:** 3/5
**CLI feel:** 3/5
**VERDICT: ELIMINATED — hard GitHub conflict.**

---

## Concept / Principle Words

### 11. Precept

| Platform | Finding |
|----------|---------|
| npm | `precept` exists — v0.1.0-alpha.0, "universal UI component library" (2023). Alpha, low use. |
| PyPI | `precept` exists — v0.6.7, async CLI application framework (2022). Real conflict — it's literally a CLI framework. |
| GitHub | CoNarrative/precept-devtools (12 stars, Clojure logic visualization). Sparse ecosystem. |

**Conflicts:** Moderate. PyPI `precept` is an async CLI framework — uncomfortably close to what we're building.
**Codex energy:** 4/5 — "A rule or instruction governing behavior" is a near-perfect semantic match. Rare word, clean sound.
**CLI feel:** 4/5 — `precept run`, `precept enforce` — clean.
**Instantly understood:** Somewhat — less common than most words on this list. Requires a moment.
**NOTE:** Strong name semantically, but PyPI occupancy by a CLI framework is an awkward conflict.

---

### 12. Rubric

| Platform | Finding |
|----------|---------|
| npm | `rubric` exists — v0.5.7, type checking library. Old, niche. |
| PyPI | `rubric` exists — v2.2.0, **"Python library for LLM-based evaluation using weighted rubrics."** Active, Python 3.10+, uses OpenAI/Anthropic. Direct conceptual conflict in the AI/LLM evaluation space. |
| GitHub | Multiple AI evaluation repos using "rubric" as a concept word. Growing usage in AI eval tooling. |

**Conflicts:** Moderate-high. PyPI `rubric` is an active LLM evaluation library — same problem domain as our tool. The word is being rapidly adopted as an AI evaluation concept.
**Codex energy:** 3/5 — Academic/educational connotation (grading rubrics). Precise but dry.
**CLI feel:** 3/5 — `rubric check` works but sounds like a grading exercise.
**Instantly understood:** Yes — criteria for evaluation. But skews academic.

---

### 13. Charter

| Platform | Finding |
|----------|---------|
| npm | `charter` exists — v0.0.2, Node.js charting library. Very old, abandoned. |
| PyPI | 404 — not registered. |
| GitHub | Sparse. No major developer tools named Charter. |

**Conflicts:** Very low. npm package is a charting library typosquat from 2013. PyPI is clean.
**Codex energy:** 4/5 — "A founding document establishing rules" — excellent semantic fit. A charter defines how an organization operates. Prestigious, serious.
**CLI feel:** 4/5 — `charter init`, `charter run`, `charter enforce` — all feel right.
**Instantly understood:** Yes — establishes the rules of operation.
**NOTE: One of the cleanest names on this list.**

---

### 14. Warrant

| Platform | Finding |
|----------|---------|
| npm | `warrant` exists — v0.0.0, OAuth2 provider stub (2014, abandoned). |
| PyPI | `warrant` exists — v0.6.1, AWS Cognito/Boto3 wrapper. Old (2017) but has 0.6.1 version. |
| GitHub | **warrant-dev/warrant** — 1,300 stars, active open-source authorization service (fine-grained access control). Real conflict in the "authorization/permissions" space. |

**Conflicts:** Moderate. The warrant-dev/warrant GitHub project is a legitimate, funded authorization tool. "Warrant" in software already means "authorization token/grant" — semantic overlap is heavy.
**Codex energy:** 3/5 — Authorization connotations are strong, which is both good and bad. The guarantee/authorization meaning works, but it's been claimed.
**CLI feel:** 4/5
**Instantly understood:** Yes, but skews toward "auth token" in developer minds.

---

### 15. Tenet

| Platform | Finding |
|----------|---------|
| npm | `tenet` exists — v0.1.0, minimal package (2020). Effectively placeholder. |
| PyPI | `tenet` exists — v0.6, ISP API wrapper (2018). Completely unrelated. |
| GitHub | Sparse dev tool usage. "Tenet" is primarily associated with the Christopher Nolan film (2020). |

**Conflicts:** Low technically, but high culturally.
**Codex energy:** 3/5 — "A principle held as true" maps well, but the Nolan film (time inversion thriller) creates confusing brand associations. Nolan's Tenet is also a registered trademark.
**CLI feel:** 3/5 — `tenet run` is odd (reverse time jokes incoming).
**Instantly understood:** Yes — but film association dominates.

---

### 16. Compact

| Platform | Finding |
|----------|---------|
| npm | `compact` exists — v1.0.0, Express JS middleware for compacting JS. Has usage. |
| PyPI | `compact` exists — v0.1.2, PHP compact() port to Python. Niche. |
| GitHub | "Compact" is an extremely common English word. Hundreds of repos use it. |

**Conflicts:** High by generic saturation. Not one dominant conflict but ubiquitous minor ones.
**Codex energy:** 2/5 — "Compact" primarily means small/dense in developer minds, not "formal agreement." The wrong meaning dominates.
**CLI feel:** 3/5
**Instantly understood:** Yes, but in the wrong direction (compact = small, not agreement).
**VERDICT: ELIMINATED — wrong semantic weight.**

---

### 17. Accord

| Platform | Finding |
|----------|---------|
| npm | `accord` exists — v0.30.0, "unified interface for compiled languages and templates in JavaScript." Active, well-known in JS tooling. |
| PyPI | `accord` exists — v0.8.1, appears to be an old Django clone/fork. |
| GitHub | `jenius/accord` on npm is a real tool used in JS build pipelines. Honda Accord brand association. |

**Conflicts:** Moderate. npm `accord` is a known JS compilation abstraction layer.
**Codex energy:** 3/5 — Agreement/harmony is nice but soft. Honda Accord is the dominant cultural association.
**CLI feel:** 3/5
**Instantly understood:** Yes — agreement. But the car association is strong.

---

## Craft / Maker Words

### 18. Arkwright

| Platform | Finding |
|----------|---------|
| npm | `arkwright` exists — v0.0.2, auto-generated CLI scaffold (2024). Very new, very sparse. |
| PyPI | 404 — not registered. |
| GitHub | `calcsam/arkwright` — the same npm package's repo. 404 on direct check. Minimal presence. |

**Conflicts:** Near-zero. The npm package is a brand-new scaffold placeholder, not an established tool.
**Codex energy:** 3/5 — Richard Arkwright invented industrial spinning. Historical weight, craft connotation. But obscure — most devs won't know the reference.
**CLI feel:** 3/5 — `arkwright build` works but the word is long and unfamiliar.
**Instantly understood:** No — requires knowledge of 18th-century industrial history.

---

### 19. Archwright

| Platform | Finding |
|----------|---------|
| npm | 404 — not registered. |
| PyPI | 404 — not registered. |
| GitHub | No repositories found for "archwright." Essentially virgin namespace. |

**Conflicts:** None found.
**Codex energy:** 3/5 — "Arch" (chief/primary) + "wright" (maker/craftsman) = chief maker. Invented compound, so meaning must be inferred. The "-wright" suffix has precedent (playwright, wheelwright, shipwright) but "arch-" prefix makes it feel coined.
**CLI feel:** 3/5 — `archwright build` is phonetically awkward (two hard consonant clusters).
**Instantly understood:** No — invented word requires explanation.

---

### 20. Stalwart

| Platform | Finding |
|----------|---------|
| npm | `stalwart` exists — v0.1.0, Express web framework (2014, abandoned). |
| PyPI | 404 — not registered. |
| GitHub | **stalwartlabs/mail-server** — 12,000 stars. "Stalwart" is the brand name of a prominent open-source Rust mail server. Active, funded, growing fast. Very strong occupant. |

**Conflicts:** HIGH. Stalwart Mail Server has 12k stars and is a flagship Rust project. The brand is established and prominent.
**Codex energy:** 3/5 — "Strong, loyal, dependable" is great conceptually but now means "email server" to many developers.
**CLI feel:** 4/5 — Good phonetics.
**VERDICT: ELIMINATED — hard GitHub conflict.**

---

## Other Single Words with Weight

### 21. Spire

| Platform | Finding |
|----------|---------|
| npm | `spire` exists — v5.0.8, "extensible CLI toolkit management tool." Active, 5.x version series. Real CLI tool. |
| PyPI | `spire` exists — v0.4.2, scientific image processing library. Different domain but registered. |
| GitHub | SPIFFE/SPIRE — CNCF project (Secure Production Identity Framework For Everyone), active cloud-native security project with enterprise adoption. |

**Conflicts:** HIGH. npm `spire` is an active CLI toolkit manager — extremely direct overlap. SPIFFE/SPIRE is a CNCF project used in production security infrastructure.
**Codex energy:** 4/5 — "Highest point" is beautiful. Clean, one syllable.
**CLI feel:** 5/5 — `spire run` is perfect.
**VERDICT: ELIMINATED — hard npm and GitHub conflicts.**

---

### 22. Parapet

| Platform | Finding |
|----------|---------|
| npm | `parapet` exists — v0.0.1, test placeholder (2017). Effectively abandoned. |
| PyPI | `parapet` exists — v0.1.0, **"Python SDK for Parapet LLM proxy firewall"** (released February 2026). Very fresh, active, same problem domain — AI agent safety/control. |
| GitHub | `peg/rampart` (53 stars) references parapet-like concepts. `highflame-ai/ramparts` (83 stars, MCP security scanner). |

**Conflicts:** Moderate-high. PyPI `parapet` (February 2026) is a brand-new LLM proxy firewall SDK — directly in the AI agent control space. Name is being actively developed in the exact same problem domain.
**Codex energy:** 3/5 — "Protective wall with oversight" is evocative but architectural/defensive rather than active/orchestrating.
**CLI feel:** 3/5 — `parapet run` doesn't flow well. Three syllables, unusual stress.
**Instantly understood:** No — requires explanation. "Parapet" is architectural vocabulary.

---

### 23. Capstone

| Platform | Finding |
|----------|---------|
| npm | `capstone` exists — v3.0.1, Node.js bindings for the Capstone disassembler. Active. |
| PyPI | `capstone` exists — v5.0.7, **major conflict** — Capstone is the most widely used open-source disassembly framework (8,600 stars on GitHub). Used in virtually every reverse engineering tool. |
| GitHub | capstone-engine/capstone — 8.6k stars. The dominant occupant. 655 repos tagged "capstone." |

**Conflicts:** CRITICAL. Capstone the disassembly framework is one of the foundational security/RE tools in existence. It has Python bindings, Node bindings, Go bindings. This name is fully taken in the security tooling world.
**Codex energy:** 4/5 — Would have been excellent. "Crowning stone" is a perfect metaphor.
**CLI feel:** 4/5
**VERDICT: ELIMINATED — hard conflict.**

---

### 24. Rampart

| Platform | Finding |
|----------|---------|
| npm | `rampart` exists — v1.0.2, deprecated Node.js authorization module. Dead. |
| PyPI | `rampart` exists — v0.2.0, **"A runtime that makes LLM agents production-safe by default"** (released March 2026). Fresh, active, directly in the AI agent safety space. |
| GitHub | `peg/rampart` (53 stars) — "Open-source firewall for AI agents" targeting Claude Code, Cursor, Codex. `highflame-ai/ramparts` (83 stars) — MCP security scanner. |

**Conflicts:** HIGH. Both PyPI and GitHub show active projects in the exact same space (AI agent safety, permission enforcement). The word is being actively colonized by the AI agent security community as of 2026.
**Codex energy:** 3/5 — Defensive fortification. Strong imagery but purely defensive, not orchestrating.
**CLI feel:** 3/5
**Instantly understood:** Somewhat — fortification, but requires knowing what fortifications do.
**VERDICT: ELIMINATED — active conflicts in same problem domain.**

---

### 25. Cornerstone

| Platform | Finding |
|----------|---------|
| npm | `cornerstone` exists — v0.1.1, JavaScript utilities from 2011. Very old. |
| PyPI | `cornerstone` exists — v0.5.1, Python project setup scaffold. Active. |
| GitHub | cornerstone3D (Cornerstone medical imaging) is a significant open-source project (~3k stars). "Cornerstone" is used across many unrelated domains. |

**Conflicts:** Moderate. PyPI package is active. Multiple projects use the name. It's a very generic foundational metaphor that everyone reaches for.
**Codex energy:** 2/5 — "Foundational stone" is conceptually right but the word is a cliché. Every startup uses "cornerstone" in marketing copy.
**CLI feel:** 2/5 — `cornerstone run` is too long and formal.
**Instantly understood:** Yes, but clichéd.

---

## Summary Table

| # | Name | npm | PyPI | GitHub Conflicts | Codex Energy | CLI Feel | Understood |
|---|------|-----|------|-----------------|:---:|:---:|:---:|
| 1 | Marshal | Minor (niche serializer) | Clean | Low | 3 | 4 | Yes |
| 2 | Warden | Minor (abandoned) | Minor | Moderate (Docker CLI) | 3 | 4 | Yes |
| 3 | **Prefect** | Minor | **MAJOR (21.9k stars)** | **CRITICAL** | 4 | 4 | Yes |
| 4 | Proctor | Minor (2014) | Moderate (test runner CLI) | Low | 2 | 3 | Yes |
| 5 | Regent | Moderate (active rules engine) | Moderate | Low | 3 | 3 | Somewhat |
| 6 | Steward | Minor | Minor (2012) | Low | 3 | 3 | Yes |
| 7 | **Captain** | Moderate (CLI tool) | **MAJOR (active CLI framework)** | High (CAPRover) | 2 | 4 | Yes |
| 8 | Arbiter | Minor | Minor | Moderate (AI tools colonizing) | 4 | 4 | Yes |
| 9 | Patron | Moderate (Discord) | Minor | Low | 2 | 2 | Yes |
| 10 | **Rector** | Minor | Minor | **MAJOR (PHP 8k stars)** | 3 | 3 | Yes |
| 11 | Precept | Minor | Moderate (CLI framework) | Low | 4 | 4 | Somewhat |
| 12 | Rubric | Minor | Moderate (LLM eval, active) | Low | 3 | 3 | Yes |
| 13 | **Charter** | Minor (old) | **Clean** | **Very Low** | 4 | 4 | Yes |
| 14 | Warrant | Minor | Minor | Moderate (auth tool 1.3k) | 3 | 4 | Yes |
| 15 | Tenet | Minor | Minor | Low (film trademark concern) | 3 | 3 | Yes |
| 16 | **Compact** | Minor | Minor | **Eliminated (wrong meaning)** | 2 | 3 | Wrong dir |
| 17 | Accord | Moderate (JS compilation) | Minor | Low | 3 | 3 | Yes |
| 18 | Arkwright | Near-zero | **Clean** | Very low | 3 | 3 | No |
| 19 | **Archwright** | **Clean (404)** | **Clean (404)** | **None found** | 3 | 3 | No |
| 20 | **Stalwart** | Minor | Clean | **MAJOR (mail server 12k)** | 3 | 4 | Yes |
| 21 | **Spire** | **MAJOR (active CLI)** | Minor | High (CNCF project) | 4 | 5 | Yes |
| 22 | Parapet | Minor | Moderate (LLM proxy, fresh 2026) | Moderate | 3 | 3 | No |
| 23 | **Capstone** | Moderate | **MAJOR (disassembler 8.6k)** | **CRITICAL** | 4 | 4 | Yes |
| 24 | **Rampart** | Minor (deprecated) | Moderate (LLM runtime, 2026) | Moderate (AI agent space) | 3 | 3 | Somewhat |
| 25 | Cornerstone | Minor | Minor | Low | 2 | 2 | Yes (cliché) |

---

## Eliminated (Hard Conflicts)

| Name | Reason |
|------|--------|
| Prefect | 21.9k-star Python orchestration platform. Trademark conflict. |
| Captain | Active PyPI CLI framework (v6.1.0) + CAPRover PaaS (12k stars). |
| Rector | rectorphp/rector has 8,300 GitHub stars. Prominent in PHP ecosystem. |
| Stalwart | stalwartlabs/mail-server has 12,000 stars. Established Rust brand. |
| Spire | Active npm CLI toolkit manager (v5.0.8) + CNCF SPIFFE/SPIRE project. |
| Capstone | World's most-used disassembly framework. PyPI v5.0.7, 8.6k stars. |
| Compact | Wrong semantic direction ("small" not "agreement"). Generic saturation. |
| Rampart | Active LLM runtime on PyPI (March 2026) + AI agent firewall on GitHub. |

---

## Top 5 — Ranked by "Would this be the next Codex/Copilot?"

### 1. Charter (Best Overall)

**Why it wins:** The PyPI namespace is clean (404). The npm package is a 2013 charting library artifact that is effectively dead. No major GitHub project owns this name. Semantically, "charter" is exactly right — a charter establishes the rules, principles, and operating agreements for an organization or endeavor. An AI orchestrator that enforces quality and sets rules for coding agents *is* a charter. The word is English, serious, and used in prestigious contexts (corporate charters, royal charters, the Magna Carta tradition). It has no wrong connotations. `charter run`, `charter init`, `charter enforce` all flow naturally. This is the cleanest name on the list.

**Codex energy:** 4/5 | **CLI feel:** 4/5 | **Understood:** Yes

---

### 2. Arbiter (Strong runner-up, act fast)

**Why it works:** Semantically ideal — the arbiter is the final decision-maker, the authority that resolves what passes and what doesn't. One syllable of command weight. The npm/PyPI conflicts are minor. The risk: the AI tooling community is organically reaching for this word right now (3+ GitHub repos using it for AI orchestration in the last two weeks). If this name is going to be used, it should be claimed before the ecosystem saturates.

**Codex energy:** 4/5 | **CLI feel:** 4/5 | **Understood:** Yes

---

### 3. Precept (Highest semantic precision)

**Why it works:** "A rule or instruction governing behavior" — this is almost the mission statement of the tool in one word. The sound is clean and rare. No developer tooling uses this word prominently. The risk is the PyPI `precept` async CLI framework — it exists at v0.6.7 but appears to have low adoption and no active community. On pure semantics and "Codex energy," Precept would score highest: it's a word most developers know but no tool has claimed, and it maps perfectly to the concept of governing AI agent behavior through explicit rules.

**Codex energy:** 4/5 | **CLI feel:** 4/5 | **Understood:** Somewhat (90% of devs know it)

---

### 4. Marshal (Clean + authoritative)

**Why it works:** Clean PyPI namespace. Minor npm conflict (niche Ruby parser). No dominant GitHub project. "Marshal" evokes someone who organizes, directs, and maintains order at large events or in command structures. The U.S. Marshal, field marshal — these are figures of serious authority who coordinate complex operations. The word is universally understood. The main risk is that "marshal" is also a common programming term (marshaling/unmarshaling data) which slightly dilutes the brand.

**Codex energy:** 3/5 | **CLI feel:** 4/5 | **Understood:** Yes

---

### 5. Warrant (Underrated, clean PyPI)

**Why it works:** "A warrant" is both an authorization and a guarantee of quality — "this code is warranted to meet standards." The dual meaning (authorization to proceed + guarantee of quality) maps remarkably well to what the tool does: it authorizes AI agents to act and guarantees the quality of their output. The npm conflict is a 2014 stub. The PyPI package is a 2017 AWS Cognito wrapper. The main GitHub conflict (warrant-dev/warrant) is an authorization service — related but distinct enough. The risk is developer association with "authorization tokens" rather than quality standards.

**Codex energy:** 3/5 | **CLI feel:** 4/5 | **Understood:** Yes

---

## Additional Notes

**Archwright** is the only candidate with a completely clean namespace (no npm, no PyPI, no GitHub). As an invented compound it has zero conflicts but also requires brand-building from zero — the word carries no pre-existing meaning for developers. Worth keeping as a safe fallback if all natural words are rejected.

**Rubric** deserves a watch: it's being rapidly adopted as terminology in AI evaluation tooling. If the project is positioned as an "evaluation and standards enforcer" rather than an "orchestrator," rubric could resurface. For now, the active PyPI LLM evaluation library creates awkward overlap.

**Tenet** — clean technically, but Christopher Nolan's 2020 film is a trademark complication that legal would need to review. The film's concept (time inversion, "don't try to understand it") also creates odd brand associations for a tool that should feel clear and trustworthy.
