# Software Quality Assurance Plan (SQAP) and Specification Improvement

**Project:** LockerKorea (E-commerce Platform)  
**Date:** 2026-02-01  
**Group ID:** K2  
**Version:** 2.0

---

## Part 1: Improvement of Specification using McCall's Quality Model

*Note: This section addresses the first part of your request regarding specification improvement.*

### 1. Product Operation Factors
*   **Correctness**: The system must calculate order totals (products, tax, shipping, vouchers) with 100% accuracy.
*   **Reliability**: The checkout process must have a 99.9% success rate during peak traffic.
*   **Integrity**: Customer personal data and Admin access must be secured via OAuth2/JWT.
*   **Usability**: The purchase flow should require fewer than 4 clicks from Cart to Order Confirmation.

### 2. Product Revision Factors
*   **Maintainability**: Backend services (Product, Order, User) must be decoupled to allow independent updates.
*   **Testability**: Pricing logic must be isolated to allow 100% unit test coverage.

### 3. Product Transition Factors
*   **Interoperability**: Must integrate seamlessly with Stripe Payment Gateway and Google Login.

### 4. Justification for Unused Factors
*   **Portability**: **Not Used**. The system is a web application targeting standard browsers, not native deployment across multiple OS architectures.
*   **Reusability**: **Low Priority**. The system is a custom brand implementation, not a generic library.
*   **Flexibility**: **Low Priority**. The focus is on a specific, rigid e-commerce workflow for the MVP.

---

## Part 2: Software Quality Assurance Plan (SQAP)

**Structure based on IEEE Std 730-2014, Annex C, Table C.2**

### 1. Purpose and scope
The purpose of this SQAP is to establish the goals, processes, and responsibilities for ensuring the quality of the **LockerKorea** e-commerce platform. The scope covers the entire software development lifecycle (SDLC) from requirements analysis to final deployment, focusing on the Angular frontend and Spring Boot backend.

### 2. Definitions and acronyms
*   **SRS**: Software Requirements Specification.
*   **SDD**: Software Design Description.
*   **SQA**: Software Quality Assurance.
*   **AUT**: Application Under Test.
*   **CI/CD**: Continuous Integration / Continuous Deployment.

### 3. Reference documents
*   IEEE Std 730™-2014, *IEEE Standard for Software Quality Assurance Processes*.
*   LockerKorea Project Requirements (SRS) - Version 1.0.
*   McCall’s Software Quality Factors.

### 4. SQA plan overview

#### 4.1 Organization and independence
The SQA function is organizationally distinct from the development team to ensure objectivity.
*   **SQA Lead**: Reports directly to the Course Instructor/Project Supervisor, not the Development Team Lead.
*   **Independence**: SQA members have the authority to reject release candidates that do not meet quality criteria, regardless of delivery pressure.

#### 4.2 Software product risk
*   **Critical Risk**: Payment processing errors (Stripe integration).
    *   *Mitigation*: Extensive sandbox testing and manual verification of transaction logs.
*   **High Risk**: Data loss during container updates.
    *   *Mitigation*: Automated backups of MySQL volumes.
*   **Medium Risk**: UI inconsistencies across devices.
    *   *Mitigation*: Responsive design testing on key viewports (Mobile, Tablet, Desktop).

#### 4.3 Tools
The following tools will be used to support SQA activities:
*   **Configuration Management**: Git / GitHub.
*   **Issue Tracking**: GitHub Issues / Jira.
*   **Automated Testing**: Jest (Frontend), JUnit (Backend).
*   **Development Environment**: Docker (ensures consistent environment conformance).
*   **API Testing**: Postman.

#### 4.4 Standards, practices, and conventions
*   **Coding Standards**:
    *   Frontend: Angular Style Guide (strict typing).
    *   Backend: Google Java Style Guide.
*   **Practices**: Test-Driven Development (TDD) for critical pricing logic.
*   **Conventions**: Semantic Versioning (SemVer) for releases (e.g., v1.0.0).

#### 4.5 Effort, resources, and schedule
*   **Effort**: SQA activities are estimated to consume 30% of total project hours.
*   **Resources**: 1 dedicated SQA Lead, 3 Developers (rotating into Peer Review roles).
*   **Schedule**: SQA reviews occur at the end of each Sprint (2-week cycles).

### 5. Activities, outcomes and tasks

#### 5.1 Product assurance

**5.1.1 Evaluate plans for conformance**
*   Review the Project Plan and Deployment Plan to ensure they comply with the course requirements and IEEE standards.

**5.1.2 Evaluate product for conformance**
*   Conduct **System Testing** to verify that the software meets all functional requirements defined in the SRS (e.g., "User can filter products by Category").
*   Check conformance to UI/UX designs.

**5.1.3 Evaluate product for acceptability**
*   Perform **Acceptance Testing (UAT)**: Validate the end-to-end "Purchase Flow" (Guest -> Cart -> Checkout -> Payment -> Email Receipt) to ensure it meets business needs.

**5.1.4 Evaluate product life cycle support for conformance**
*   Verify that the documentation (User Manual, Installation Guide) is accurate using the deployed version of the software.

**5.1.5 Measure products**
*   **Defect Density**: Track number of bugs per feature module.
*   **Test Coverage**: Ensure >70% code coverage for Backend Services.

#### 5.2 Process assurance

**5.2.1 Evaluate life cycle processes for conformance**
*   Audit the development process to ensure Code Reviews are being performed *before* merging PRs.

**5.2.2 Evaluate environments for conformance**
*   Verify that the Docker dev environment matches the production configuration (PHPMyAdmin, MySQL 8 versions) as defined in `deployment.yaml`.

**5.2.3 Evaluate subcontractor processes for conformance**
*   *Note: No subcontractors.* Verify reliability of external APIs (Stripe, Google Auth) via health checks and mock testing.

**5.2.4 Measure processes**
*   **Cycle Time**: Measure time taken from "In Progress" to "Done".
*   **Review Efficiency**: Percentage of defects found during Peer Review vs. Testing.

**5.2.5 Assess staff skill and knowledge**
*   Ensure all team members are trained on the project's standard tools (Angular CLI, Maven commands) and the Git branching strategy.

### 6. Additional considerations

#### 6.1 Contract review
*   Review the "Project Assignment" requirements from the university to ensure all deliverables (Source code, Report, Demo) are accounted for.

#### 6.2 Quality measurement
*   Use SonarQube or simple linting reports to measure technical debt and code quality trends over time.

#### 6.3 Waivers and deviations
*   Any deviation from this Plan (e.g., skipping unit tests for a minor UI prototype) must be documented and approved by the SQA Lead.

#### 6.4 Task repetition
*   Regression testing tasks are repeated before every major release.

#### 6.5 Risks to performing SQA
*   **Risk**: Lack of time due to academic deadlines.
*   **Mitigation**: Automate critical tests (Pricing, Login) to reduce manual checking time.

#### 6.6 Communications strategy
*   Weekly "Quality Sync" meeting (15 mins) to discuss open critical bugs.
*   GitHub Issues used for asynchronous communication on defects.

#### 6.7 Non-conformance process
*   If a deliverable fails SQA Review (e.g., Build fails, Critical bug found):
    1.  Item is marked "Rejected".
    2.  Detailed feedback is provided in the Issue Tracker.
    3.  Developer must fix and resubmit.

### 7. SQA records

#### 7.1 Analyze, identify, collect, file, maintain and dispose
*   **Identify**: Test Plans, Test Logs, Review Meeting Minutes, Bug Reports.
*   **Maintain**: Stored in the `/docs/sqa` directory of the project repository.
*   **Dispose**: Archived at the end of the semester.

#### 7.2 Availability of records
*   All SQA records are public to the team and available on the GitHub repository for instructor review at any time.
