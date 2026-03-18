# Naming Research — Round 3

**Date:** 2026-03-18
**Scope:** 20 candidates across public domain fiction, Latin/historical titles, invented words, and concept words. Checked GitHub, npm, PyPI for conflicts. Includes 10 new candidates and a final top-5 ranked by "Prime-like weight."

---

## Research Methodology

For each candidate:
1. GitHub search for major conflicting repos and star counts
2. General web search for existing products using the name
3. npm search via npmjs.com
4. PyPI search via pypi.org
5. Wikipedia check for public domain status (fiction names)

Ratings (1–5 scale):
- **Weight**: Does it sound like THE leader? The primary authority?
- **CLI feel**: Does `<name> build` / `<name> run` / `<name> deploy` feel natural?
- **Distinctiveness**: Would people confuse it with something already established?

---

## Section 1: Public Domain Fiction Leaders

### 1. Virgil

**Context:** Dante's guide through Hell and Purgatory in the Divine Comedy (written ~1308–1321). Virgil the Roman poet lived 70 BC–19 BC — ancient and fully public domain. The character embodies reason, judgment, and the trusted guide who leads you through danger.

**Conflicts found:**
- **VirgilSecurity** — A significant security/encryption company (VirgilSecurity on GitHub). Has `virgil-cli`, `virgil-sdk`, `virgil-crypto` npm packages with real usage. The npm namespace `virgil-*` is heavily occupied by this company.
- `clj-commons/virgil` — Clojure REPL Java recompiler
- The name "Virgil" is strongly associated with VirgilSecurity in developer contexts.

**Public domain:** Yes. Both the historical poet and Dante's use of him are centuries out of copyright.

**Verdict:** Moderate conflict. VirgilSecurity has claimed the developer namespace effectively. `virgil build` would cause confusion. Usable but carries baggage.

| Metric | Score | Notes |
|---|---|---|
| Weight | 4 | Strong guide/protector connotations |
| CLI feel | 3 | `virgil deploy` works but feels literary |
| Distinctiveness | 2 | VirgilSecurity has the mindshare |

---

### 2. Nestor

**Context:** The oldest, wisest Greek leader at Troy in the Iliad. Not a fighter — an advisor whose counsel others defer to. Purely mythological, entirely public domain.

**Conflicts found:**
- `cliffano/nestor` — Node.js Jenkins API and CLI (GitHub). This is an active, published npm package.
- `arunthampi/nestor-cli` — A real "Nestor" bot platform with CLI that lets teams deploy chat bot powers. Had an org and product.
- `usnistgov/nestor-web` — NIST maintenance intelligence tool.
- The npm package `nestor` exists and maps to the Jenkins CLI tool.

**Public domain:** Yes. Homeric mythology, 3000+ years old.

**Verdict:** Moderate-to-high conflict. There is a real developer tool called Nestor with a real CLI. Not a blockbuster but enough to cause confusion.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | "Wise counselor" is not as strong as "the first" |
| CLI feel | 3 | `nestor run` is okay |
| Distinctiveness | 2 | Existing CLI tools with this name |

---

### 3. Mycroft

**Context:** Sherlock Holmes's older, smarter brother in Conan Doyle's stories. Famously described as the man who "is the British government" — the invisible orchestrator. A perfect archetype for an AI orchestrator.

**Conflicts found:**
- **Mycroft AI** — A well-known open-source voice assistant company (MycroftAI on GitHub with ~6,000+ stars on `mycroft-core`). The company shut down in early 2023 due to patent litigation, but the GitHub org, repos, and brand name remain widely indexed. The community continuation is OpenVoiceOS.
- The name Mycroft = AI assistant in public consciousness from the 2016–2023 period.

**Public domain status:** Complicated. Arthur Conan Doyle died in 1930. Under US copyright law (pre-1928 rule), stories published before 1928 are in the public domain. The Mycroft character appears in stories from 1893 and 1917 — both public domain in the US. (There was a long-running dispute over post-1923 Holmes stories, resolved ~2023.)

**Verdict:** High conceptual conflict. The name "Mycroft AI" is deeply embedded in developer memory as an AI voice assistant. Even though the company is dead, using "Mycroft" for a new AI orchestrator would constantly invite the question "is this related to Mycroft AI?" The ghost of the brand is too strong. Skip.

| Metric | Score | Notes |
|---|---|---|
| Weight | 5 | The orchestrator archetype is perfect |
| CLI feel | 3 | `mycroft run` feels a bit soft |
| Distinctiveness | 1 | Dead brand but powerful ghost; would cause confusion |

---

### 4. Prospero

**Context:** The sorcerer-duke of Shakespeare's The Tempest (written ~1610–1611). He orchestrates every event on the island through his spirit-agents (primarily Ariel). The ultimate orchestrator of other agents. Extremely apt metaphor.

**Conflicts found:**
- `wildfly/prospero` — Active, maintained CLI tool for provisioning and updating WildFly application servers. This is a real, current project backed by Red Hat. Has releases, docs, and CLI usage (`./prospero install`).
- `jonmorehouse/prospero-build` — Web build tool.
- Multiple GitHub orgs named "prospero" exist.

**Public domain:** Yes. Shakespeare died 1616. All his works are public domain everywhere.

**Verdict:** Meaningful conflict. The WildFly `prospero` CLI is a real, actively maintained tool in the Java/enterprise ecosystem. Not a household name among general developers, but a genuine namespace conflict. The metaphor is superb but the name is taken in CLI space.

| Metric | Score | Notes |
|---|---|---|
| Weight | 5 | Orchestrates agents — literally the archetype |
| CLI feel | 4 | `prospero deploy` has gravitas |
| Distinctiveness | 2 | WildFly tool occupies the CLI namespace |

---

### 5. Oberon

**Context:** King of the fairies in Shakespeare's A Midsummer Night's Dream (written ~1595–1596). Commands authority; others obey. Also note: Oberon is a programming language designed by Niklaus Wirth (1986) and an associated operating system.

**Conflicts found:**
- **Oberon programming language** — A real, still-discussed language by Niklaus Wirth. Multiple active GitHub repos: `rochus-keller/Oberon`, `oberon-lang`, `andreaspirklbauer/Oberon-extended`. The name has a long technical history.
- **Oberon operating system** — Project Oberon is a complete OS also by Wirth, with active GitHub mirrors.
- The programming language and OS give this name significant prior developer association.

**Public domain:** Yes. Shakespeare public domain; the name itself is even older (appears in 13th-century French romance Huon de Bordeaux).

**Verdict:** High conflict from the programming language angle. Any developer who knows systems programming will immediately think "Wirth's language." Too much technical baggage.

| Metric | Score | Notes |
|---|---|---|
| Weight | 4 | "King who commands" is strong |
| CLI feel | 3 | `oberon build` is fine |
| Distinctiveness | 1 | Wirth's language has strong developer mindshare |

---

### 6. Athos

**Context:** Leader of the Three Musketeers in Alexandre Dumas' novels (1844). Quiet authority — the others defer to him despite d'Artagnan being the main character. Noble, reliable, the one others follow.

**Conflicts found:**
- No major developer tool named Athos found.
- A GitHub user `athos` (Shogo Ohta) with Clojure tools, but no product named "Athos."
- `atos-tools/atos-utils` exists but is a different name (ATOS, not Athos).
- Also note: Athos is a mountain/peninsula in Greece (Mount Athos, Orthodox monastic community) — some association but not software.

**Public domain:** Yes. Dumas died 1870; Three Musketeers published 1844. Firmly public domain in all jurisdictions.

**Verdict:** Low conflict. Clean namespace. The character resonates — quiet authority, natural leader, others follow without being ordered. Less flamboyant than "Prime" but carries dignity.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | "Quiet authority" is understated but real |
| CLI feel | 4 | `athos run` / `athos build` feel clean and crisp |
| Distinctiveness | 4 | Clean namespace; not confused with anything major |

---

## Section 2: Titles/Concepts with Weight

### 7. Princeps

**Context:** Latin "first citizen" — the title Augustus chose to disguise his monarchy as a republic. From this comes "principal," "prince," "principal engineer." It means: the first among all, the one who leads.

**Conflicts found:**
- No npm package named `princeps` found. Search returned similar names (prince, primus, princejs) but not princeps.
- No PyPI package named `princeps` found.
- No significant GitHub project named Princeps found.
- A Wikipedia article on Princeps exists confirming the historical meaning.

**Verdict:** Minimal conflict. Clean namespace across npm, PyPI, and GitHub. Strong etymological connection to "prime," "principal," and leadership. Has gravitas without being pretentious. Slightly obscure — most people won't know it immediately, but that can be a feature (it feels learned, weighty).

| Metric | Score | Notes |
|---|---|---|
| Weight | 5 | The literal root of "principal" and "prime" |
| CLI feel | 4 | `princeps build` has authority; slightly stiff |
| Distinctiveness | 5 | Essentially unclaimed in software namespace |

---

### 8. Primo

**Context:** Italian/Spanish for "first" or "best." Used colloquially (as in "primo quality"). Has warmth and confidence.

**Conflicts found:**
- **Primo CMS** — A real, active Svelte-based visual CMS with a GitHub org (`primoCMS`). Has real users.
- **ExLibris Primo** — A major library discovery system used worldwide by universities. The name "Primo" in library/academic technology is strongly associated with Ex Libris (now owned by Clarivate). Has multiple GitHub dev environment repos.
- `primosoftware` GitHub org exists.

**Verdict:** High conflict. Primo is taken by multiple products. The ExLibris association alone (a major enterprise software product used at thousands of universities) makes this a poor choice.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | Feels casual rather than gravitas |
| CLI feel | 3 | `primo deploy` is fine |
| Distinctiveness | 1 | Multiple existing products; Ex Libris is major |

---

### 9. Mandate

**Context:** An authoritative order — "the mandate of heaven" (Chinese philosophical concept), "executive mandate." Conveys absolute authority to act.

**Conflicts found:**
- No npm package named `mandate` found specifically.
- No PyPI package named `mandate` found.
- No significant GitHub tool named Mandate found (searches returned generic results about npm/CLI tooling, not a product called Mandate).

**Verdict:** Low conflict on namespaces. However, "mandate" as a product name has a political connotation problem — in post-2020 discourse, "mandate" carries strong negative associations (vaccine mandates, executive mandates as overreach). The word has baggage that would distract from technical gravitas. The concept is strong but the word is politically loaded.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | Authority concept is right but word is fraught |
| CLI feel | 3 | `mandate run` is grammatically odd |
| Distinctiveness | 4 | Clean namespace |

---

### 10. Vindex

**Context:** Latin for "champion," "defender," "avenger" — one who stands up for others, the protector. Also a historical figure: Gaius Julius Vindex, the governor who first rose against Nero, triggering the Year of the Four Emperors.

**Conflicts found:**
- `sm-vindex/vindex` on GitHub — A React application, not a developer tool.
- `vindex` GitHub org exists but appears minimal.
- `fast-vindex` exists on PyPI (a data indexing tool).
- No significant CLI tool or developer tool named Vindex found.

**Verdict:** Low conflict. The PyPI `fast-vindex` is a niche data library, not a product. The name is mostly clean. "Vindex" has a slightly harsh, defensive connotation rather than "the first/prime" connotation the user wants. More "defender" than "leader." Strong word but wrong concept.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | "Defender/champion" is strong but not "the first" |
| CLI feel | 4 | `vindex build` is crisp and distinct |
| Distinctiveness | 4 | Mostly clean namespace |

---

### 11. Tribune

**Context:** Roman Tribune of the Plebs — an official with sacrosanct veto power over any action of the Roman state. The people's protector with absolute veto authority.

**Conflicts found:**
- `tribune` npm package exists — a Consul service discovery module (last published 9 years ago, abandoned).
- Tribune Publishing has a GitHub org.
- Minnesota Star Tribune has a GitHub org.
- The word "Tribune" is strongly associated with media companies (Chicago Tribune, etc.).

**Verdict:** Moderate conflict. The media association ("Tribune" = newspaper) is significant. A developer tool called Tribune would constantly be associated with journalism, not authority. The npm package is abandoned but squatting the name.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | Roman authority concept correct but word feels journalistic |
| CLI feel | 3 | `tribune run` sounds like a newspaper command |
| Distinctiveness | 2 | Strong media brand association |

---

### 12. Brehon

**Context:** Ancient Irish judge-lawgiver. The Brehon Laws were the legal system of pre-Norman Ireland. A Brehon was an authoritative interpreter of the law — their judgment was final. Esoteric, genuinely distinctive, carries ancient authority.

**Conflicts found:**
- No npm package named `brehon` found. Search returned unrelated results (bree, brew).
- No PyPI package named `brehon` found.
- No GitHub project named Brehon found in searches.

**Verdict:** Minimal conflict. Extremely clean namespace. The word is almost entirely unknown outside Irish history scholars — which cuts both ways. It's distinctive and unclaimed, but it requires explanation. Does not have "immediate resonance" — you would need to tell every user "Brehon was an ancient Irish judge." That said, after one explanation, the meaning is powerful and memorable.

| Metric | Score | Notes |
|---|---|---|
| Weight | 4 | Ancient authority + judgment = strong concept |
| CLI feel | 3 | `brehon run` is odd; feels ceremonial |
| Distinctiveness | 5 | Completely clean namespace; highly memorable once explained |

---

### 13. Cato

**Context:** Cato the Elder and Cato the Younger — Roman statesmen of absolute, unwavering principle. "Cato" evokes incorruptible integrity, the person whose judgment cannot be bought or swayed.

**Conflicts found:**
- **Cato Networks** — A major enterprise SASE/security company with significant GitHub presence (`catonetworks` org), a real Python CLI tool (`cato-cli` on PyPI), Terraform providers, and Go SDK. A well-funded, real company.
- `cato-react-store` npm package exists.
- `tranHieuDev23/Cato` — An online judge system on GitHub.
- `Latios96/cato` — A visual regression testing tool.
- PyPI: Cato Networks' CLI is a real published package.

**Verdict:** High conflict. Cato Networks is a significant enterprise software company. Their CLI tool is published on PyPI. This name is taken in a meaningful way.

| Metric | Score | Notes |
|---|---|---|
| Weight | 4 | Roman principle + integrity is strong |
| CLI feel | 4 | `cato build` is clean |
| Distinctiveness | 1 | Cato Networks occupies this namespace |

---

## Section 3: Invented Words with "Real Word Energy"

### 14. Straton

**Context:** Invented compound: "stratum" (layer, foundation) + "archon" (Greek for ruler/leader). Sounds ancient Greek, feels like it could be a real historical title.

**Conflicts found:**
- No npm package named `straton` found. (`stratton` npm package exists as a different word; `stratos` exists.)
- No PyPI package named `straton` found. (`stratos` exists on PyPI.)
- `sircoko/moon-design-straton` exists on GitHub but is a design system component, not a product.
- `github.com/topics/straton` exists but is minimal.

**Verdict:** Low conflict. The name is essentially clean. The invented etymology is transparent and appealing (stratum = foundation/layers + archon = ruler). Feels like it could be a real word from classical antiquity. Strong "real word energy."

| Metric | Score | Notes |
|---|---|---|
| Weight | 4 | "Ruler of layers/foundations" works for an orchestrator |
| CLI feel | 4 | `straton build` / `straton run` feel clean and modern |
| Distinctiveness | 5 | Essentially invented; namespace is clean |

---

### 15. Preon

**Context:** Physics: in some speculative theories, preons are proposed as the most fundamental sub-quark constituents of matter — the thing below quarks, the most basic building block. Conveys: the thing everything else is built from, the indivisible foundation.

**Conflicts found:**
- `preon` PyPI package — "PREcision Oncology Normalization," a medical fuzzy-search library. Active and maintained.
- `preonJs/preon` GitHub — A Node.js micro-service framework (small project).
- The medical/oncology tool has real usage.

**Verdict:** Moderate conflict. The medical tool on PyPI uses this name. The Node framework is minor. The physics concept is appealing but the name is not clean on PyPI.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | "Most fundamental particle" is conceptually interesting but abstract |
| CLI feel | 3 | `preon deploy` sounds disconnected from authority |
| Distinctiveness | 2 | PyPI conflict with medical tool |

---

### 16. Regis

**Context:** Latin genitive: "of the king." As in "Rex" (king), "Regis" = belonging to the king, of kingly quality. Used in names like "Corpus Christi Regis." Conveys: this belongs to the highest authority.

**Conflicts found:**
- `regis` npm package exists (a lightweight npm package, though low usage).
- `ReGIS-org/regis` — A Research Environment for GIS on GitHub.
- `trivoallan/regis-cli` — A Container Security & Policy-as-Code Orchestration CLI tool on GitHub.
- The GIS research tool and the security CLI both use this name.

**Verdict:** Moderate conflict. There's an npm package and a dedicated CLI tool called `regis-cli`. Not dominant conflicts but not clean either.

| Metric | Score | Notes |
|---|---|---|
| Weight | 4 | "Of the king" is strong Latin gravitas |
| CLI feel | 4 | `regis build` / `regis run` feel authoritative |
| Distinctiveness | 3 | Some npm/GitHub conflicts but not dominant |

---

## Section 4: Concept Words

### 17. Crux

**Context:** The decisive point, the critical factor — "the crux of the matter." Conveys centrality and importance.

**Conflicts found:**
- **XTDB (formerly Crux)** — Crux was the name of the immutable bitemporal database (now XTDB) by JUXT. The GitHub repo at `xtdb/xtdb` (formerly `juxt/crux`) has ~2,000+ stars. The name change happened in 2022 (release 1.19.0 "Goodbye Crux, long live XT!"), but the old name is well-remembered.
- `redbadger/crux` — An active, maintained cross-platform Rust framework (~1,500+ stars). This is a real, current project.
- `GaloisInc/crucible` (different but adjacent).
- `crux-api` npm package — Chrome UX Report API wrapper.
- `etienne-bechara/crux` — Node.js backend framework.
- Multiple active, significant projects use this name.

**Verdict:** High conflict. Two significant, active GitHub projects (Red Badger Crux ~1,500 stars, former XTDB Crux ~2,000 stars) occupy this name. The developer community associates "Crux" with the cross-platform Rust framework particularly. Skip.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | "The decisive point" is strong but feels like a feature not a leader |
| CLI feel | 4 | `crux build` is crisp |
| Distinctiveness | 1 | Multiple major GitHub projects with this name |

---

### 18. Axiom

**Context:** A self-evident truth, a foundational principle that requires no proof. Conveys: this is the bedrock, the undeniable foundation.

**Conflicts found:**
- **Axiom, Inc.** — A well-funded observability/logging company. Has an active CLI (`axiomhq/cli` on GitHub, ~500+ stars), npm packages, Python SDK. The company has 87+ repos. The name "Axiom" is firmly associated with their observability platform.
- `axiom` npm package exists (published by Axiom, Inc.).
- `axiom-rust` GitHub — A Rust streaming framework also named Axiom.

**Verdict:** High conflict. Axiom the observability company has strong developer brand presence with an active CLI tool. This name is effectively taken in the developer tools space.

| Metric | Score | Notes |
|---|---|---|
| Weight | 4 | Self-evident truth = strong foundational concept |
| CLI feel | 4 | `axiom build` sounds authoritative |
| Distinctiveness | 1 | Axiom observability company owns this in developer mindshare |

---

### 19. Bastion

**Context:** A stronghold, a defensive fortification — the key point of defense that cannot be bypassed.

**Conflicts found:**
- `bastion` npm package exists (published, not abandoned — Bastion BaaS).
- `Olical/bastion` — Deprecated JavaScript build tool, but still visible.
- `Bastion-BaaS/bastion-cli` — A Backend-as-a-Service CLI (globally installable npm package).
- `bastion-rs/bastion` — A Rust actor framework (formerly active).
- `cloudposse/bastion` — A Docker container security bastion solution.
- `ovh/the-bastion` — A major SSH access management tool from OVH.
- `vagmi/bastion` — SSH bastion automation.
- The term "bastion host" / "bastion server" is generic infrastructure terminology for SSH jump hosts. Every DevOps engineer knows this term in that context.

**Verdict:** High conflict. "Bastion" in DevOps/infrastructure means SSH jump server. This is generic technical terminology with multiple real products built on it. The defensive/protective connotation also positions this as a security tool, not an orchestrator.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | Strength/defense is good but not "the first/prime" |
| CLI feel | 4 | `bastion run` feels natural |
| Distinctiveness | 1 | Infrastructure term + multiple real products |

---

### 20. Crucible

**Context:** The vessel in which things are tested under extreme heat — where metals are refined, where character is forged. Used metaphorically for intense tests. The crucible is where the real thing emerges.

**Conflicts found:**
- **Atlassian Crucible** — Atlassian's legacy code review tool (now discontinued, but was a major enterprise product for years). Extremely well-known in the Java/enterprise development world.
- `git-crucible` npm package exists.
- `kelumkps/git-crucible-cli` — A CLI tool for Atlassian Crucible integration.
- `GaloisInc/crucible` — A symbolic simulation library (~300+ stars, active).
- `perftool-incubator/crucible` — A performance testing automation framework.
- `cmu-sei/crucible` — Carnegie Mellon's virtual environment framework.

**Verdict:** High conflict. Atlassian Crucible is the dominant association for any enterprise developer — a product they've almost certainly used or heard of. Multiple other active tools use this name.

| Metric | Score | Notes |
|---|---|---|
| Weight | 3 | Transformation/testing concept is strong but not "the leader" |
| CLI feel | 4 | `crucible build` is evocative |
| Distinctiveness | 1 | Atlassian Crucible brand is dominant |

---

## Summary Conflict Matrix

| # | Name | npm conflict | PyPI conflict | GitHub conflict | Overall conflict |
|---|------|-------------|---------------|-----------------|-----------------|
| 1 | Virgil | High (VirgilSecurity) | Low | High (VirgilSecurity) | High |
| 2 | Nestor | Moderate (Jenkins CLI) | Low | Moderate (bot platform) | Moderate |
| 3 | Mycroft | Low | Low | High (Mycroft AI ghost) | High |
| 4 | Prospero | Low | Low | Moderate (WildFly tool) | Moderate |
| 5 | Oberon | Low | Low | High (Wirth language/OS) | High |
| 6 | Athos | Low | Low | Low | Low |
| 7 | Princeps | None found | None found | None found | Minimal |
| 8 | Primo | Moderate | Low | High (Ex Libris, CMS) | High |
| 9 | Mandate | Low | Low | Low | Low |
| 10 | Vindex | Low | Low (fast-vindex) | Low | Low |
| 11 | Tribune | Moderate (npm, media) | Low | Moderate | Moderate |
| 12 | Brehon | None found | None found | None found | Minimal |
| 13 | Cato | High (Cato Networks) | High (PyPI CLI) | High | High |
| 14 | Straton | None found | None found | Low | Minimal |
| 15 | Preon | Low | Moderate (oncology) | Low | Moderate |
| 16 | Regis | Moderate (npm) | Low | Moderate (regis-cli) | Moderate |
| 17 | Crux | Moderate (crux-api) | Low | High (2 major repos) | High |
| 18 | Axiom | High (Axiom Inc.) | Low | High (87+ repos) | High |
| 19 | Bastion | High (npm) | Low | High (multiple) | High |
| 20 | Crucible | Moderate (git-crucible) | Low | High (Atlassian ghost) | High |

---

## Section 5: 10 New Candidates (Brainstorm)

### New Candidates — Rationale and Quick Check

**A. Archon**
Greek: "the ruler," "the chief magistrate." An archon was the highest elected official in ancient Athens. The word sounds powerful, modern, and technical. However: `coleam00/Archon` is an active AI coding assistant tool with real users, `Decentralised-AI/Archon-agent-builder` exists, and `archon` appears in several active repos. Conflict: moderate-to-high. `archon build` sounds excellent. Weight: 5. But the namespace is increasingly occupied by AI tools specifically.

**B. Praetor**
Latin: the magistrate ranking just below a consul, with judicial and military authority. "Praetorian" derives from this. Distinct, serious, historical. Conflicts: `akash-network/praetor-frontend` is an active Akash blockchain tool; `praetor-data` (LLM finetuning tool); `tjunlp-lab/Praetor` (LLM evaluator); Praetorian security firm. Conflict: moderate. Namespace mostly clear on npm/PyPI but the word is being adopted in AI tooling specifically.

**C. Dux**
Latin: "the leader," the root of "duke," "Il Duce," "ductile." Simple, powerful, short. Conflicts: `dux` npm package exists (a CLI scaffold helper); `joshkehn/dux` GitHub project; `duckinator/dux` (an OS). Conflict: moderate. The word is also tainted by association with Mussolini ("Il Duce" = the Dux).

**D. Strategos**
Ancient Greek: "the general," "the strategist" — the elected military commander of Athens who set overall strategy. The root of "strategy." `Blackfall-Labs/strategos` exists on GitHub as a CLI tool for archive management. `strategosio` GitHub org exists. Conflict: low-to-moderate. The word is longer but carries real weight. `strategos build` sounds authoritative.

**E. Hegemon**
Greek: "the leader," "the one who goes before" — from which "hegemony" derives. Conveys dominance and primacy without aggression. Conflicts: `p-e-w/hegemon` is a real Rust system monitor on GitHub (though appears inactive since ~2018). Conflict: low. `hegemon run` / `hegemon build` feel natural. Clean enough.

**F. Voivode** (also spelled Voivoda)
Slavic: "war-leader," "he who leads the army." The title of princes in medieval Poland, Transylvania, Wallachia. Vlad the Impaler was a Voivode. Exotic, almost unknown in software. Completely clean namespace (no conflicts found). However: the Dracula/Vlad association is the first thing many Westerners will think. Unusual pronunciation (VOY-vode).

**G. Suzerain**
Medieval French/English: a sovereign who allows vassals to govern themselves but retains ultimate authority. "The suzerain relationship" — the top-level power that delegates but remains supreme. Conflicts: a minor GitHub project exists but nothing significant. The word is elegant, English-adjacent, and uniquely conveys "supreme authority that orchestrates through others." Weight: 5. CLI feel: 3 (`suzerain build` is long). Distinctiveness: 5.

**H. Imperator**
Latin: "commander," the root of "emperor." Julius Caesar's soldiers acclaimed him Imperator after victories. It became the word for supreme commander. Conflicts: `Imperator` appears in gaming contexts (Crusader Kings III character). Some GitHub repos but nothing dominant in developer tooling. The word is extremely powerful but potentially overwrought — does it feel like a product name or a villain's title?

**I. Aleph**
Hebrew: the first letter of the Hebrew alphabet. As a concept, Aleph means "the first," "the beginning," "the primordial." Jorge Luis Borges used it for the point containing all points. In Cantor's mathematics, Aleph-null (ℵ₀) is the smallest infinity. Conflicts: multiple small GitHub projects, an npm package exists for Aleph.js (Deno React framework, fairly active), `aleph` PyPI package exists. Conflict: moderate. But the "first letter = the first" concept is compelling.

**J. Lodestar**
Old English/Norse: the guiding star — specifically the North Star (Polaris) that navigators used to find true north. "The lodestar" = the fixed point everything else orients to. Conflicts: `ChainSafe/lodestar` is a major Ethereum consensus client with thousands of stars, npm packages, and an active community. Conflict: high. Beautiful word but taken.

---

### Quick Reference — New Candidates

| Name | Weight | CLI feel | Distinctiveness | Conflict level |
|------|--------|----------|-----------------|----------------|
| Archon | 5 | 5 | 2 | Moderate-high (AI tools adopting it) |
| Praetor | 4 | 4 | 3 | Moderate |
| Dux | 4 | 4 | 2 | Moderate (Il Duce association; npm taken) |
| Strategos | 4 | 4 | 4 | Low-moderate |
| Hegemon | 4 | 4 | 4 | Low (inactive conflict) |
| Voivode | 3 | 3 | 5 | Minimal (Dracula problem) |
| Suzerain | 5 | 3 | 5 | Minimal |
| Imperator | 5 | 4 | 3 | Low-moderate (gaming association) |
| Aleph | 4 | 4 | 2 | Moderate (Aleph.js) |
| Lodestar | 4 | 4 | 1 | High (Ethereum client) |

---

## Final Top 5 — Ranked by "Prime-like Weight"

Criteria for this ranking: the feeling that this is THE orchestrator, THE leader — the way "Prime" immediately communicates primacy. Secondary factor: namespace cleanliness. Tertiary factor: CLI feel.

---

### 1. Princeps

**Rating: Weight 5 / CLI 4 / Distinctiveness 5**

The etymological root of "principal," "prince," and by extension "prime." When Augustus chose *princeps* as his title, he was deliberately signaling "I am the first citizen, the one who stands before all others." The word embeds the concept of primacy so deeply that every derivative in Western languages points back to it. No meaningful conflicts on npm, PyPI, or GitHub. Clean namespace.

`princeps build` — sounds authoritative and weighty.
`princeps run` — clean.
`princeps deploy` — unmistakable.

The slight drawback: it requires a moment of recognition. Not everyone will immediately parse it. But for the target audience of developers who care about names with history and meaning, this lands perfectly. It sounds like it was always the name for this.

---

### 2. Suzerain

**Rating: Weight 5 / CLI 3 / Distinctiveness 5**

Uniquely captures the architecture of an AI orchestrator: supreme authority that works *through* subordinates, not instead of them. A suzerain doesn't do the work — a suzerain commands the vassals who do. For a tool that orchestrates AI agents, this is an almost perfect conceptual fit. The word sounds English, is pronounceable, and is distinctive. Near-zero namespace conflict.

Drawback: it's long (3 syllables), and `suzerain build` takes a beat. Some users may find it pretentious. But for a product that wants gravitas, this might be a feature.

---

### 3. Straton

**Rating: Weight 4 / CLI 4 / Distinctiveness 5**

The strongest of the invented words. The compound etymology (stratum + archon = "ruler of layers/foundations") is transparent to anyone with a little Greek/Latin, and for everyone else it simply sounds ancient and serious. It has no real-world conflicts. The invented nature means it can be defined entirely on its own terms. `straton build` has exactly the right cadence — two syllables, punchy, modern-feeling while rooted in antiquity.

This may be the most usable option: high weight, excellent CLI feel, zero conflicts.

---

### 4. Prospero

**Rating: Weight 5 / CLI 4 / Distinctiveness 2**

The metaphor is the best of any candidate: Shakespeare's sorcerer orchestrates every event through his spirit-agents. If the product didn't have the WildFly CLI conflict, this would be #1. The WildFly `prospero` tool is real and maintained, which creates genuine namespace tension. However, it's a niche tool in the Java enterprise space — a developer in the Python/TypeScript/AI agent space is unlikely to encounter it. The conflict is real but may be acceptable depending on the audience.

---

### 5. Imperator

**Rating: Weight 5 / CLI 4 / Distinctiveness 3**

"Commander" — the word from which "emperor" descends. Julius Caesar's troops shouted it after victories. It is unambiguous about authority. No dominant npm/PyPI/GitHub conflicts found. The gaming association (Crusader Kings, Paradox titles) slightly undercuts the professional tone, and it risks feeling theatrical. But for an AI development orchestrator targeting senior engineers, "Imperator" may land with exactly the right amount of intentional audacity.

---

## Appendix: Eliminated Candidates and Reasons

| Candidate | Primary elimination reason |
|-----------|---------------------------|
| Mycroft | Brand ghost of Mycroft AI voice assistant; too strong an association |
| Axiom | Axiom, Inc. observability company owns this namespace |
| Cato | Cato Networks occupies PyPI and GitHub |
| Crux | Red Badger Crux framework (~1,500 stars, active) and XTDB/Crux legacy |
| Bastion | Infrastructure terminology (bastion host); multiple real products |
| Crucible | Atlassian Crucible brand ghost; multiple active tools |
| Oberon | Wirth's programming language has strong developer mindshare |
| Virgil | VirgilSecurity owns npm and GitHub namespace |
| Primo | Ex Libris Primo (major university library product) |
| Tribune | Newspaper/media brand association; npm package squatted |
| Lodestar | ChainSafe Lodestar (Ethereum client, thousands of stars) |
| Mandate | Political word with negative associations post-2020 |

---

*Research conducted 2026-03-18. Package availability subject to change. GitHub star counts are approximate based on search snippets.*
