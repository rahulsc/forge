# Naming Research Round 4 — Focused Candidate Analysis

**Date:** 2026-03-18
**Scope:** Six candidates — Arkwright, Precept, Percept, Karyon, KaryonForge, Archwright
**Registries checked:** GitHub (orgs + repos), npm registry API, PyPI JSON API, crates.io API

---

## Summary Table

| Candidate | npm | PyPI | crates.io | GitHub org | Verdict |
|-----------|-----|------|-----------|------------|---------|
| Arkwright | TAKEN (v0.0.2, 2024) | Clear | Clear | No org (user only) | Marginal conflict |
| Precept | TAKEN (v0.1.0-alpha.0) | TAKEN (v0.6.7) | TAKEN (v0.3.0) | No org | Heavy conflict |
| Percept | TAKEN (v0.0.1, 2011) | TAKEN (v0.14, 2013) | Clear | No org | Moderate conflict |
| Karyon | TAKEN (v5.1.0, active) | Clear | Clear | karyontech org exists | Heavy conflict |
| KaryonForge | Clear | Clear | Clear | No org | Clean |
| Archwright | Clear | Clear | Clear | No org | Clean + real-world builder company |

---

## 1. Arkwright

### Concept
Arkwright (common noun) means a maker of arks — wooden chests or coffers. The word combines "ark" (chest) with "wright" (maker/craftsman). Richard Arkwright (1732–1792) was the English inventor and industrialist widely credited as the father of the factory system and the Industrial Revolution, most famous for the water frame spinning machine and the world's first water-powered cotton mill at Cromford (1771).

### Wikipedia
Richard Arkwright has a full, prominent Wikipedia article: https://en.wikipedia.org/wiki/Richard_Arkwright — one of the most significant figures in British industrial history. "Arkwright" as a standalone common noun does not have its own Wikipedia article (it redirects to information about arks or the Arkwright surname).

### GitHub
- **User account:** `github.com/arkwright` — Robert Arkwright, individual developer in Toronto. 21 repositories, all Vim plugins. Top repo: `arkwright.github.io` (45 stars). Low-impact user, not a project or org.
- **GitHub org `arkwright`:** Does not exist (404 on `/orgs/arkwright`). The username is taken by the individual above.
- **No major software project** uses this name on GitHub.

### npm
- **Package `arkwright` EXISTS:** Version 0.0.2, published August 14, 2024. Maintainer: `calcsam`. Listed as a CLI tool (ES module, `dist/cli.js` entry point, Node >=16). The README is auto-generated placeholder text referencing "bellefond," suggesting this was a scaffolded experiment with `create-pastel-app`. Extremely minimal — almost certainly abandoned scaffolding. MIT license.
- This is a real squatted/stub npm package, not a mature project.

### PyPI
- **Not found** — `pypi.org/pypi/arkwright/json` returns 404. Name is clear on PyPI.

### crates.io
- **Not found** — `crates.io/api/v1/crates/arkwright` returns 404. Name is clear on crates.io.

### Non-software brand associations
- **Arkwright Consulting** — major Northern European management consulting firm (offices in Oslo, Stockholm, Hamburg, London), founded 1987. Active and prominent.
- **Arkwright Digital** — digital transformation firm, part of Arkwright Group. Active.
- **Arkwright Group** — consortium: Arkwright Consulting + Arkwright Digital + Arkwright X + Arkwright Corporate Finance.
- **Arkwright Home** — home textiles company, exports to 75 countries.
- Strong, well-established consulting/digital brand in Europe.

### Assessment
The npm package is a stub (2024 scaffolding experiment, 0.0.2, placeholder readme) but it is taken. PyPI and crates.io are clear. The GitHub username is taken by an individual (not an org). The `Arkwright` name carries significant brand weight from the Arkwright Group consulting family and Arkwright Digital — a European firm that competes directly in the "digital" space. The historical resonance (father of the industrial revolution, maker of things) is strong. The npm conflict is minor but real.

---

## 2. Precept

### Concept
Precept (Latin: *praeceptum*, "something taken before") means a rule or principle intended to guide behavior or thought. From *prae-* (before) + *capere* (to take). Wikipedia has a dedicated article: https://en.wikipedia.org/wiki/Precept — the word is defined as "a commandment, instruction, or order intended as an authoritative rule of action," with uses in religion, law, and education (Princeton uses "precept" for discussion sections).

### Wikipedia
Strong article exists. The word has rich multi-domain meaning: religious commandments (Five Precepts in Buddhism), legal writs, educational discussion sections. **Precept Ministries International** is a large interdenominational Christian organization (founded 1970, operates in 180 countries, translated into 70 languages) — a major non-software brand association.

### GitHub
Multiple substantial repos using this name:
- **CoNarrative/precept** — "A declarative programming framework" for ClojureScript. **663 stars.** Rules-engine-based reactive web framework. Active-looking repo, 490 commits.
- **T4rk1n/precept** — "Async command line application toolbox" (Python). 2 stars, but directly relevant: this is a Python CLI builder framework. 218 commits.
- **electronics-and-drives/precept** — Machine learning CLI extension for PREDICT Toolbox. Also ships two CLIs (`pct`, `prc`).
- No `precept` GitHub org found.

### npm
- **Package `precept` EXISTS:** Version `0.1.0-alpha.0`. "The universal UI component library." Author: Mark McCann. Last modified February 9, 2023. Active-ish (alpha status).

### PyPI
- **Package `precept` EXISTS:** Version `0.6.7`. "Async cli application builder." Active Python package by T4rk1n. This is specifically a CLI framework — directly in conflict with the tool-naming use case.

### crates.io
- **Crate `precept` EXISTS:** Version `0.3.0`. "A testing utility for fuzzing and fault injection to discover erroneous and interesting states." Last updated February 13, 2026 — actively maintained. ~1,072 downloads. By Carl Sverre (inspired by Antithesis Rust SDK).

### Non-software brand associations
- **Precept Ministries International** — well-known Christian ministry, large publishing presence, Amazon storefront, worldwide reach.

### Assessment
**Heavily conflicted.** All four major registries are taken. The PyPI package is a CLI builder (direct conceptual conflict). The crates.io package was updated in February 2026 (very recently). The CoNarrative/precept GitHub project has 663 stars. Additionally the religious brand association (Precept Ministries) creates reputational complication. **Not recommended.**

---

## 3. Percept

### Concept
Percept (Latin: *perceptum*) means an object of perception — a mental impression formed by sensory experience. In AI/cognitive science, a percept is the input an intelligent agent receives at a given moment, forming part of a "percept sequence." Wikipedia has a specific article: https://en.wikipedia.org/wiki/Percept_(artificial_intelligence) — and a disambiguation page: https://en.wikipedia.org/wiki/Percept_(disambiguation).

### Wikipedia
The AI sense is well-documented (Russell & Norvig definition). The general sense (psychology/philosophy) redirects to the Perception article. Not a standalone major concept article, but has a dedicated AI page. The word is in active academic use.

### GitHub
Multiple repos:
- **GetPercept/percept** — "Give your AI agent ears. Open-source ambient voice intelligence for AI agents." 2 stars. Active, recent (60 commits, CHANGELOG, ROADMAP). AI/voice tool. GitHub org `GetPercept` exists.
- **PerceptTools/percept** — Parallel mesh refinement and adaptivity tools for finite element method. 5 stars. C++/Wolfram. Scientific computing. GitHub org `PerceptTools` exists.
- **VikParuchuri/percept** — Modular ML framework. 9 stars. **Archived October 15, 2024.**
- **erlang/percept** — Erlang concurrency profiling tool. 21 stars. Under official Erlang org.
- **sandialabs/percept** — Sandia National Laboratories. Scientific mesh tool (likely a fork of PerceptTools).
- **Spatial-Data-Science-and-GEO-AI-Lab/percept** — Street view human perception project.

No `percept` GitHub org (the username/org at that exact name is not taken, but multiple orgs with Percept in their name exist: `GetPercept`, `PerceptTools`).

### npm
- **Package `percept` EXISTS:** Version `0.0.1`. "A generic realtime multiplayer server and client to plug into your games." Author: Gabe Hollombe. Created October 18, 2011. Very old, unmaintained (Node >=0.4.3, depends on socket.io 0.8.0). Effectively abandoned.

### PyPI
- **Package `percept` EXISTS:** Version `0.14`. "Modular machine learning framework that is easy to test and deploy." Published July 9, 2013. Very old, abandoned. Corresponds to `VikParuchuri/percept` on GitHub (archived 2024).

### crates.io
- **Not found** — `crates.io/api/v1/crates/percept` returns 404. Name is clear on crates.io.

### Non-software brand associations
- **Microsoft Azure Percept** — Microsoft had an Azure Percept developer kit (edge AI hardware). This product line was discontinued, but it was a high-profile Microsoft product. Association with AI/perception technology.
- The word is in common use in AI/ML/cognitive science writing.

### Assessment
Moderate conflict. npm and PyPI are technically taken but both packages are very old and abandoned (2011, 2013). crates.io is clear. The GitHub landscape has several small/niche projects using the name under various orgs. The AI meaning creates positive resonance for an AI coding tool, but also means the name is actively used in AI contexts. The Microsoft Azure Percept association (even defunct) adds noise. The name is available in practice for new use but has legacy squatters on npm/PyPI. **Possible if willing to accept legacy squats; not pristine.**

---

## 4. Karyon

### Concept
Karyon (Greek: κάρυον) means "nut" or "kernel" — the essential core or nucleus of a cell. It is a Greek root used in many biology terms: eukaryote (true-kernel), karyolysis, karyorrhexis, karyogamy, etc. Wikipedia does not have a standalone "Karyon" article; the term redirects or appears within the Cell nucleus and Eukaryote articles. The word means the deepest essential core.

### Wikipedia
No standalone Wikipedia article for "karyon" as a concept. The term appears within: Cell nucleus (https://en.wikipedia.org/wiki/Cell_nucleus), Eukaryote, Karyolysis, Karyorrhexis, Karyogamy. It is a technical Greek root, not a common English word.

### GitHub
The name has heavy GitHub presence:
- **Netflix/karyon** — "The nucleus or the base container for Applications and Services built using the NetflixOSS ecosystem." **495 stars.** Last release v2.9.2, January 4, 2018. README explicitly states: "Karyon 2.0 is no longer supported. We are in the process of retiring Karyon." Not archived but effectively dead. High-profile Netflix OSS project.
- **karyontech/karyon** — "A library for building p2p, decentralized, and collaborative software." 43 stars. Written in Rust (99.8%). Active. Under **karyontech** GitHub org (which exists).
- **Gabaldonlab/karyon** — Genome assembly pipeline for highly heterozygous genomes.
- **sami-b95/karyon** — Minimalist Unix-like hobby OS in C.
- **karyon** (user account: Johannes Linke) — Personal GitHub user, graphics/rendering researcher.

### npm
- **Package `karyon` EXISTS and is ACTIVE:** Version `5.1.0`. "A reactive kernel for creative apps." Author: Sergey Dirzu. Homepage: https://karyon.dev. Keywords: JavaScript, Reactive, UI. MIT license. This is a live, actively maintained reactive DOM library — a direct competitor-space npm package.

### PyPI
- **Not found** — `pypi.org/pypi/karyon/json` returns 404. Name is clear on PyPI.

### crates.io
- **Not found** — `crates.io/api/v1/crates/karyon` returns 404. Name is clear on crates.io.

### Non-software brand associations
- **Karyon Global Corporation** — IT services and staffing company, USA.
- **Karyon Food** — Data valuation software for agri-food industry, Paris, France (founded 2019).
- **Karyon Consultoria em Informática** — Brazilian IT/healthcare software firm.
- **karyon.dev** — domain is taken (by the npm package's reactive JS library).
- **karyon.ca** — Canadian company (terms & conditions page found).
- **karyon.organic** — another Karyon-branded entity.
- The name is in wide commercial use across IT, food tech, and healthcare sectors.

### Assessment
**Heavily conflicted.** The npm package is active at v5.1.0 with a live website (karyon.dev). Netflix/karyon has 495 stars and is well-known in the Java/cloud ecosystem even though it's retired. The `karyontech` GitHub org is active with a Rust library. Multiple commercial companies use this name. **Not recommended as a standalone name.**

---

## 5. KaryonForge

### Concept
A compound of Karyon (Greek: kernel/nucleus — the essential core) + Forge (the project's existing name / a forge/smithy metaphor for making things). Emphasizes: the essential, generative core of the forge.

### GitHub
- No repository or organization named `karyonforge` found anywhere on GitHub. Search for "karyonforge" on GitHub returns zero results matching the exact compound.
- The closest results are all plain "karyon" repos (Netflix, karyontech, Gabaldonlab).

### npm
- **Package `karyonforge` does NOT exist.** Registry API (`registry.npmjs.org/karyonforge`) returns 404. **Name is available.**

### PyPI
- **Package `karyonforge` does NOT exist.** API returns 404. **Name is available.**

### crates.io
- **Crate `karyonforge` does NOT exist.** API returns 404. **Name is available.**

### Non-software brand associations
- No companies, products, or brands using the exact compound "KaryonForge" found.
- The compound is entirely invented; the only associations are the constituent words (Karyon and Forge).

### Notes
- The `karyon` part of the name carries baggage: Netflix/karyon (well-known Java framework, retired), karyon npm (active JS library), karyontech org (active Rust library), and multiple commercial companies. Anyone encountering "KaryonForge" who knows the space will associate it with the karyon ecosystem.
- The Greek root meaning (kernel/nucleus) does align well conceptually with a tool that manages the core of a software project.
- The compound is pronounceable: "KAIR-ee-on-forge."

### Assessment
**Technically clean** — all registries are clear. But the `karyon` component carries significant existing brand weight in software (Netflix, active npm package, Rust library). Whether this is association or confusion depends on positioning. Clean for registration; potentially confusing for discovery.

---

## 6. Archwright

### Concept
An invented compound: "arch" (chief, principal — from Greek *arkhos*, ruler/chief) + "wright" (maker, craftsman — Old English *wyrhta*). Meaning: chief maker, master craftsman. Not a real historical word; entirely coined.

### GitHub
- No repository or organization named `archwright` found on GitHub.
- Search for "archwright" returns only: `DiamondLightSource/arcwright` (note: no "h" — spelled "arcwright") — tools for integrating data from the XPDF-ARC detector at a UK synchrotron facility. This is a different spelling (`arcwright` vs `archwright`).
- Also found: `Archwright Labs (@archwrightlabs)` — an X/Twitter account that joined January 2025 with the tagline "Empowering Everyday Innovators." Very new, no public GitHub presence found, no website found.

### npm
- **Package `archwright` does NOT exist.** Registry API returns 404. **Name is available.**

### PyPI
- **Package `archwright` does NOT exist.** API returns 404. **Name is available.**

### crates.io
- **Crate `archwright` does NOT exist.** API returns 404. **Name is available.**

### Non-software brand associations
- **Archwright Fine Home Builders & Estate Management** — custom home builder in Duxbury, Massachusetts (South Shore/Cape Cod area). Founded 2016 by Brian Lafauce and Cara Meneses. Voted Best of South Shore Builder for 2023 and 2024. Has a live website (archwright.com) and uses proprietary client-facing software for project management.
- **Archwright Labs** — an X/Twitter account (@archwrightlabs) with tagline "Empowering Everyday Innovators." Very new (January 2025), no public product found. Could be a nascent tech startup.
- No large established software company with this name.

### Notes
- The spelling distinction from `arcwright` (the Diamond Light Source tool) means there is no direct collision, but the one-letter difference (`archwright` vs `arcwright`) could cause occasional confusion in written form.
- The Archwright home builder company (archwright.com) holds the primary domain and has a meaningful, well-branded presence in the construction/craftsmanship space — thematically adjacent to the "wright" (maker) concept.
- The invented compound is easy to say: "ARCH-wright." Clear syllable break.

### Assessment
**Technically clean** on all registries. Real-world collision is limited to a Massachusetts custom home builder (archwright.com — domain taken) and a nascent X account. The name is available for software use but the `.com` domain is held by the builder. Strong conceptual meaning (chief maker). Minor concern around the home builder brand and the near-miss `arcwright` spelling.

---

## Cross-Candidate Comparison

### Registry Availability Matrix

| Registry | Arkwright | Precept | Percept | Karyon | KaryonForge | Archwright |
|----------|-----------|---------|---------|--------|-------------|------------|
| **npm** | TAKEN (stub, 2024) | TAKEN | TAKEN (old, 2011) | TAKEN (active v5.1.0) | Available | Available |
| **PyPI** | Available | TAKEN (active v0.6.7) | TAKEN (old, 2013) | Available | Available | Available |
| **crates.io** | Available | TAKEN (active v0.3.0, updated Feb 2026) | Available | Available | Available | Available |
| **GitHub org** | User (not org) | Not found | Not found | karyontech exists | Not found | Not found |

### Conflict Severity

| Candidate | Severity | Primary blockers |
|-----------|----------|-----------------|
| Precept | **BLOCKED** | npm + PyPI + crates.io all taken; crates.io updated Feb 2026; 663-star GitHub framework |
| Karyon | **BLOCKED** | Active npm package (v5.1.0, karyon.dev); Netflix/karyon (495 stars); karyontech org active |
| Percept | **Moderate** | npm + PyPI taken (both abandoned, 2011/2013); multiple GitHub projects; MS Azure Percept history |
| Arkwright | **Low** | npm stub (v0.0.2, 2024, placeholder readme); Arkwright Group consulting brand in Europe |
| KaryonForge | **Low/None** | All registries clear; karyon component carries brand baggage |
| Archwright | **Low/None** | All registries clear; archwright.com taken by home builder; Archwright Labs X account |

### Strongest Candidates (least conflicted)

1. **Archwright** — All three registries clear. Only conflicts are a Massachusetts home builder (archwright.com) and a very new X account. Strong, pronounceable, invented compound with clear meaning (chief maker). The `.com` domain being taken is a practical concern.

2. **KaryonForge** — All three registries clear. Zero existing software projects with this compound name. The downside is the `karyon` component's existing ecosystem baggage (Netflix, active npm, active Rust library). Anyone searching "karyon" will find a different world of software.

3. **Arkwright** — npm has a stub but it is clearly abandoned scaffolding (placeholder readme, v0.0.2). PyPI and crates.io are clear. The name has excellent historical resonance (father of the industrial revolution, maker-craftsman). The Arkwright Group/Arkwright Digital consulting brand in Europe is a real but non-software-tool conflict. The GitHub username is taken by an individual developer but no org exists.

---

## Recommendations

**If seeking a completely clean slate:** KaryonForge or Archwright. Both have zero registry conflicts.

**If willing to accept minor friction:** Arkwright — the npm package is an obvious abandoned stub, PyPI and crates.io are free, and the historical/conceptual resonance is outstanding. The European consulting firm Arkwright Digital is the main non-software concern.

**Eliminate from consideration:** Precept (too many active conflicts across all registries, including a crates.io crate updated in February 2026), Karyon (active npm package at v5.1.0 with its own website).

**Proceed with caution:** Percept — registries technically available in practice (very old abandoned packages on npm/PyPI, crates.io clean), but the Microsoft Azure Percept association and multiple GitHub projects with this name make discovery noisy.
