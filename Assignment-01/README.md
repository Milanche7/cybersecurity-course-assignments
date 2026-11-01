# Assignment 01 — Cybersecurity Risk Assessment & Treatment Report

**Author:** Milan Nikolic  |  **Track:** Cybersecurity  |  **Project type:** Scenario-based security risk assessment

> **Scope note:** This is an educational assessment of a hypothetical accounting company, not a penetration test, production audit, or evidence of vulnerabilities in a real organization. Ratings and assumptions are illustrative.

## Executive summary

This report examines the security posture of a hypothetical accounting services company that processes sensitive financial records, business documentation, and client personal information. The company relies on servers hosted in rented data-center space, remote employee and administrator access through VPN, and site-to-site VPN connections with selected clients.

The assessment identifies **23 business and technology assets**, evaluates **23 risk scenarios**, recommends safeguards for **14 high/critical risks**, and provides a cost-benefit treatment decision for **four priority areas**. The central finding is that identity security, data protection, backup recoverability, and employee awareness are interdependent: one well-designed control can reduce exposure across several assets.

**Risk distribution:** 9 critical · 5 high · 8 moderate · 1 low.

## Contents
- [Business context and scope](#business-context-and-scope)
- [Methodology](#methodology)
- [Asset inventory](#asset-inventory)
- [Risk register](#risk-register)
- [Control strategy](#control-strategy)
- [Cost-benefit analysis and treatment decisions](#cost-benefit-analysis-and-treatment-decisions)
- [Implementation roadmap](#implementation-roadmap)
- [Validation, limitations, and lessons learned](#validation-limitations-and-lessons-learned)

## Business context and scope

The organization must maintain the **confidentiality, integrity, and availability (CIA)** of financial ledgers, client data, contracts, operational records, and systems used by staff. The assessment covers digital and physical information, endpoints, servers, databases, access credentials, network connectivity, third-party hosting dependencies, employee knowledge, and operational processes.

**Assumptions:** The scenario does not provide an independently verified network diagram, control inventory, vulnerability scan, incident history, or financial loss data. Severe ratings therefore describe plausible *conditional* situations (for example, missing MFA or poorly segmented privileged access), not verified facts about an existing company.

## Methodology

I used a qualitative **5 × 5 risk matrix**, evaluating one representative threat scenario for each asset:

`Risk score = Likelihood (1–5) × Impact (1–5)`

| Score | Priority |
|---:|---|
| 1–4 | Low |
| 5–9 | Moderate |
| 10–16 | High |
| 17–25 | Critical |

Likelihood estimates how plausible the scenario is **under the stated assumptions**; impact considers disruption, loss of sensitive information, financial consequences, trust, and potential legal exposure. These thresholds are defined for this project and are **not presented as an ISO-prescribed scale**.

## Asset inventory

The inventory spans information assets, infrastructure, identities, processes, and people. Each asset has a corresponding risk scenario in the register below.

| ID | Asset | Why it matters |
|---:|---|---|
| 01 | Financial ledgers | Core accounting and transaction evidence |
| 02 | Business documents and records | Contracts, obligations and operational documentation |
| 03 | Client personal data | Sensitive client information and privacy obligations |
| 04 | Endpoints and connected devices | Daily work and potential entry points into the environment |
| 05 | Business applications | Tools used to process information and access systems |
| 06 | VPN connectivity | Remote and inter-organizational connectivity |
| 07 | Servers and databases | Primary storage and processing of business data |
| 08 | Company information system | Enables day-to-day information workflows |
| 09 | Colocation server rack | Physical hosting of critical servers |
| 10 | User and administrator accounts | Defines access to applications and privileged resources |
| 11 | Network availability | Connects employees, servers and services |
| 12 | Employee records and offboarding | Supports accurate identity lifecycle management |
| 13 | Client directory | Supports correct identification and servicing of clients |
| 14 | Backup data and infrastructure | Enables restoration after loss or ransomware |
| 15 | Client communications | Carries client instructions and confidential files |
| 16 | Company logs and records | Provides evidence of activity and business decisions |
| 17 | Firewall | Enforces network traffic restrictions |
| 18 | Routers and switches | Supports routing, switching and network operation |
| 19 | Passwords and VPN keys | Grants access to sensitive services and tunnels |
| 20 | Email system | Primary channel for client and internal communication |
| 21 | Data center service agreement | Defines service levels and responsibilities |
| 22 | Business processes | Provides repeatable and safe business operations |
| 23 | Employee security knowledge | Influences recognition of attacks and error reporting |

## Risk register

The following table preserves the original assessment scores and prioritization. A score is an **inherent/scenario risk estimate**; residual risk was not quantitatively rescored after controls.

| ID | Asset | Representative risk scenario | L | I | Score | Priority |
|---:|---|---|---:|---:|---:|---|
| 01 | Financial ledgers | Unauthorized access, ransomware, loss of financial records | 4 | 5 | **20** | Critical |
| 02 | Business documents and records | Theft, disclosure, or deletion of contracts and documents | 3 | 4 | **12** | High |
| 03 | Client personal data | Unauthorized disclosure of client personal information | 5 | 5 | **25** | Critical |
| 04 | Endpoints and connected devices | Endpoint compromise and potential lateral movement | 5 | 5 | **25** | Critical |
| 05 | Business applications | Exploitation of outdated applications causing disruption | 3 | 3 | **9** | Moderate |
| 06 | VPN connectivity | Compromised VPN credentials or keys enabling unauthorized access | 5 | 5 | **25** | Critical |
| 07 | Servers and databases | Server/database intrusion, exfiltration or destruction | 5 | 5 | **25** | Critical |
| 08 | Company information system | Short outage of a limited information-system component | 3 | 2 | **6** | Moderate |
| 09 | Colocation server rack | Physical intrusion into a secured colocation rack | 1 | 5 | **5** | Moderate |
| 10 | User and administrator accounts | Compromise of a privileged account | 5 | 5 | **25** | Critical |
| 11 | Network availability | DDoS affecting internet-facing connectivity | 4 | 2 | **8** | Moderate |
| 12 | Employee records and offboarding | Former employee account remains active after departure | 4 | 5 | **20** | Critical |
| 13 | Client directory | Impersonation using outdated client information | 2 | 4 | **8** | Moderate |
| 14 | Backup data and infrastructure | Backup server compromise and backup deletion | 3 | 5 | **15** | High |
| 15 | Client communications | Impersonation or tampering with client correspondence | 2 | 4 | **8** | Moderate |
| 16 | Company logs and records | Unauthorized alteration or deletion of business records | 3 | 4 | **12** | High |
| 17 | Firewall | Firewall compromise or temporary network disruption | 2 | 3 | **6** | Moderate |
| 18 | Routers and switches | Physical damage or unauthorized device connection | 1 | 4 | **4** | Low |
| 19 | Passwords and VPN keys | Theft or misuse of passwords and VPN keys | 4 | 5 | **20** | Critical |
| 20 | Email system | Email account compromise and confidential-data exposure | 3 | 5 | **15** | High |
| 21 | Data center service agreement | Unclear service responsibilities or availability terms | 2 | 4 | **8** | Moderate |
| 22 | Business processes | Employee errors caused by unclear procedures | 3 | 4 | **12** | High |
| 23 | Employee security knowledge | Phishing and other incidents resulting from insufficient training | 4 | 5 | **20** | Critical |

### Interpretation of the most significant exposures

- **Identity compromise is a common attack path.** VPN access, user/admin accounts, stored secrets and email can provide an attacker with a foothold. The actual blast radius depends on access rights and network segmentation; VPN access alone does not imply unrestricted server access.
- **Data recovery is a separate security requirement.** Protecting production databases is not enough if attackers can also delete the backups. Segregated, protected copies and tested restoration are necessary.
- **People and processes are part of the security boundary.** Training, offboarding and clear procedures reduce the chance of avoidable incidents and help teams detect problems sooner.
- **Physical and third-party risks remain relevant.** Data-center security and contractual responsibilities matter even where the estimated likelihood is lower.

## Control strategy

Controls were selected for **all 14 high and critical risk scenarios**, prioritizing prevention, limiting damage, and enabling recovery. The recommendations below are proposed safeguards; they were not deployed or tested in the hypothetical company.

| Asset ID | Risk | Proposed controls |
|---:|---|---|
| 01 | Financial ledgers | Restrict digital ledger access; protect physical storage; maintain secured backups |
| 02 | Business documents and records | Limit document access; protect physical archives; retain recoverable copies |
| 03 | Client personal data | Security-awareness training, network segmentation, least privilege and MFA |
| 04 | Endpoints and connected devices | Patch management, strong authentication, least privilege and endpoint protection |
| 06 | VPN connectivity | Secure VPN key handling, MFA where supported, software updates and access restrictions |
| 07 | Servers and databases | Server hardening, patching, privileged-access restrictions and MFA where supported |
| 10 | User and administrator accounts | MFA, strong-password policy, role separation, least privilege and training |
| 12 | Employee records and offboarding | Accurate employee records and prompt account deprovisioning |
| 14 | Backup data and infrastructure | Segment backup infrastructure, restrict access, protect extra copies and test restores |
| 16 | Company logs and records | Restrict record modification/deletion; segment systems and back up critical records |
| 19 | Passwords and VPN keys | Password manager, protected key storage, MFA and staff training |
| 20 | Email system | Email filtering, anti-phishing training, strong authentication and MFA |
| 22 | Business processes | Clear accessible procedures and checks for sensitive activities |
| 23 | Employee security knowledge | Recurring awareness training, concise instructions and non-punitive error reporting |

### How the safeguards work together

**Defense in depth:** Security awareness reduces exposure to social engineering; MFA adds a barrier if a password is stolen; least privilege limits what a compromised account can do; segmentation limits movement to other systems; protected backups improve recovery if preventive measures fail. None of these controls is a guarantee on its own.

**Security operations:** Regular updates reduce known software vulnerabilities. Access reviews and prompt offboarding prevent unnecessary accounts from remaining active. Restricted modification rights and recoverable records help preserve business evidence.

**Human factors:** Concise instructions make secure behavior easier. Encouraging prompt reporting of accidental mistakes, rather than automatically punishing employees for them, improves the chance of early incident detection.

## Cost-benefit analysis and treatment decisions

Four priority areas were selected for a qualitative cost-benefit review. Costs are relative estimates rather than vendor quotes or a completed budget. The chosen response in all four cases is **mitigation**, because the company cannot reasonably stop using these capabilities and the proposed controls can reduce meaningful exposure.

| Risk area | Initial score | Estimated cost | Business benefit | Treatment |
|---|---:|---|---|---|
| Backup infrastructure | 15 (High) | Medium | Recover data after deletion/ransomware and reduce prolonged outages | **Mitigate** |
| Servers and databases | 25 (Critical) | Low–medium, depending on existing controls | Reduce unauthorized access, data loss and service disruption | **Mitigate** |
| Employee security knowledge | 20 (Critical) | Low–medium | Fewer avoidable errors; earlier recognition and reporting of attacks | **Mitigate** |
| User and administrator accounts | 25 (Critical) | Low–medium | Make credential misuse harder and reduce compromised-account impact | **Mitigate** |

### 1. Backup infrastructure — mitigate

A separated and properly maintained backup environment requires storage capacity, administrator time, access controls, and routine recovery tests. This is a **medium-cost** investment relative to the scenario. It is justified because the financial and operational impact of irrecoverable accounting records could be substantially higher. The objective is to retain usable copies even when primary data is damaged or encrypted.

### 2. Servers and databases — mitigate

Hardening, patching, secure configuration, and access reviews primarily require administrator effort, although some tools may introduce licensing costs. The estimated **low-to-medium cost** is justified by the importance of systems that process client and financial data. A successful intrusion could cause major service interruption, data loss, and loss of client trust.

### 3. Employee security knowledge — mitigate

Training requires staff time, concise documentation, and potentially external instruction, resulting in a **low-to-medium cost**. It supports safer daily work, better phishing recognition, and earlier reporting of suspicious activity. Education does not eliminate human error, but it can lower the likelihood and impact of mistakes across multiple workflows.

### 4. User and administrator accounts — mitigate

Configuring MFA, password requirements, and least-privilege access requires administrator time and may involve licensing. The **low-to-medium cost** is justified because a compromised privileged account could expose a large part of the environment. MFA helps resist password-only compromise; least privilege reduces the potential damage when access is obtained.

**Why not accept, avoid, or transfer these risks?** Accepting the assessed high/critical exposure would leave important business functions insufficiently protected. Avoiding these activities would undermine core accounting operations. Contractual transfer or insurance might offset some financial consequences, but it would not replace the company’s obligation to secure systems and data.

## Implementation roadmap

The sequence below is a **proposed plan**, not a record of implementation:

1. **Immediate priorities:** Review privileged access, enforce MFA where supported, remove unnecessary access, verify backup isolation and restore capability.
2. **Near-term hardening:** Patch critical systems, review VPN and server configurations, strengthen email filtering, and document employee offboarding.
3. **Operationalization:** Publish concise procedures, train employees, schedule access reviews and backup recovery exercises.
4. **Ongoing review:** Reassess risks after material system or business changes and verify controls multiple times per year.

## Validation, limitations, and lessons learned

### What this project demonstrates

- Building an asset inventory that includes technology, data, people, processes and third-party dependencies.
- Connecting a threat scenario to likelihood, impact, risk priority and a proportionate security control.
- Comparing the cost of safeguards with potential business harm instead of choosing controls only for technical reasons.
- Recognizing shared dependencies: for example, MFA and least privilege affect several risk scenarios at once.

### Limitations and next steps

- The assessment uses **scenario assumptions**, not direct technical evidence. A real engagement would validate architecture, access permissions, controls and relevant business requirements.
- Risk likelihood and impact are qualitative estimates; no incident-frequency data or monetary loss model was available.
- Control effectiveness and **residual risk** have not been measured. Future work would define control owners, evidence, test results and revised risk scores.
- A future iteration could add a risk owner, control owner, due date, evidence reference, and review date to each register entry.

### Closing observation

Security measures should be reviewed **several times each year** and whenever the environment changes. Many risks and safeguards overlap: improving one control—such as access management, segmentation or employee awareness—can reduce exposure in multiple parts of the organization.

---

**Project:** Assignment 01 · Cybersecurity learning portfolio · **Author:** Milan Nikolic
