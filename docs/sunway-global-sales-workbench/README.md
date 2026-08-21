# Sunway Global Sales Workbench Skill

这是 `maintain-global-sales-workbench` 的可移植封装，用于根据 Outlook 邮件、报价附件和业务表格创建、核验、维护并发布国际业务工作台。

## 内容

- `WORKBENCH_PRODUCTION_WORKFLOW.md`：完整工作台生产和日常同步流程。
- `skill/SKILL.md`：Skill 入口、触发条件和核心操作规则。
- `skill/agents/openai.yaml`：Skill 显示信息与默认调用提示。
- `skill/references/data-contract.md`：客户、报价、合并、最低价和空值规则。
- `skill/references/workbench-production-workflow.md`：Skill 使用的详细流程参考。

## 核心原则

- 所有业务字段必须能追溯到邮件、附件、已上传表格或已核验页面。
- 缺失信息留白，不自动补算、猜测或跨币种比较。
- 相同客户仅在身份依据充分时合并。
- 公司网址只在明确要求时由非公共企业邮箱后缀生成，并标记为邮件后缀网址。
- 报价最低价只在客户、产品/型号、币种和单位均相同时比较。

## 推荐用法

在支持 Skills 的环境中安装 `skill/` 目录，然后使用：

```text
Use $maintain-global-sales-workbench to sync verified Outlook and attachment data into the international sales workbench.
```

## 当前工作台

https://sunway-global-sales.soulmateforever.chatgpt.site
