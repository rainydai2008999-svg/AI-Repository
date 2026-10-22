# 项目结构和故障定位

项目根目录：`D:\市场开发\外贸开发信小助手`

## 代码地图

- `server.js`：Express 应用、安全校验、中间件、客户/RFQ/API 路由。
- `db.js`：SQLite 连接和 schema/migration。动数据库前先读真实 schema 和现有迁移。
- `sync.js`、`monitor-inbox.js`：本地文件导入、RFQ 标准化和去重。
- `rfq-workflow.js`、`platform-collector.js`、`rfq-scheduler.js`：平台采集执行、任务状态、时段记录。启动器和平台登录状态以当前文件为准。
- `outreach.js`：客户邮件组、草稿版本、内容校验和当前列表。
- `manual-mail.js`、`outreach-routes.js`：单封审批门禁、邮箱确认、发送状态机及 HTTP API。
- `mail.js`：Outlook/SMTP/IMAP 适配和连接状态。绝不打印密钥。
- `ai-config.js`：AI 配置与调用审计；Key 不进入报告或浏览器。
- `public/app.js`、`public/outreach-ui.js`、`public/manual-mail-ui.js`、`public/manual-send-ui.js`：审核台和开发信页面交互。
- `启动助手.ps1`、`关闭助手.ps1`、`查看状态.ps1`、`scripts/local-supervisor.js`：本机启动、停止、状态查询和恢复。

## 关键诊断区分

- A 本地导入：看实际文件、mtime/hash、解析结果、行级错误、import log 和数据库/API；不得启动平台浏览器。
- B 平台同步：逐平台核对任务运行 ID、当前平台页面、关键词/分页覆盖、详情结果、落盘文件、导入结果和审核页面。旧文件导入不能算实时读取成功。
- 403 CSRF：确认页面 session token 是否刷新、正常页面提交时的 Cookie/头、服务重启后获取新 token 的流程。不得关闭校验或硬编码 token。
- `spawn EPERM`：核对实际 executable、参数数组、工作目录、启动脚本调用方式、进程账户和原始错误；不要无证据归咎安全软件。
- CDP 超时/网站 503：检查端口、进程、指定 Chrome 配置、已打开标签、真实 URL/标题和页面可见文本；分辨本机连接问题与网站响应。不得绕过 CAPTCHA 或账户限制。
- 邮件审核被拒：读取 `/api/outreach/messages/:id/review` 的真实 issues；确认是客户未同意、邮箱未确认、正文验证、过期来源、暂停还是版本过期，不要一刀切放宽门禁。
- 发送状态：按 DB/API 的状态机和 Outlook 已发送文件夹核对；如状态 uncertain，先核查 Message-ID，不重发。

## 修改与验收

- 写代码前指出改哪些文件以及为何；优先最小、可回滚修改。
- 数据库结构/生产数据更改前做完整 SQLite 备份并 integrity check。
- 业务验收优先用既有真实记录，只读核对。不要为验证而批准真实客户草稿或向客户发送邮件。
- 用户要求代码验证时，针对改动执行最小必要验证；将语法、隔离测试、接口验收、页面点击和真实外部服务结果分开报告。
- 浏览器界面权限不可用时，不伪称完成页面点击。继续能独立完成的代码和只读 API 核验，并把页面操作步骤写清楚。
