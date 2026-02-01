# PromptMaster - 发布准备清单

## 📋 社区发布准备

### 1. 项目描述
**标题**：PromptMaster - AI 提示词模板库

**一句话介绍**：
> 超过 500+ 个高质量 AI 提示词模板，提升你的 AI 生产力

**详细描述**：
PromptMaster 是一个免费的 AI 提示词模板库，帮助开发者、内容创作者和创作者节省时间、获得更好的 AI 输出结果。

### 核心功能
- ✅ 5 个免费模板：代码审查、内容创作、邮件撰写、数据分析、研究总结
- ✅ 1 个高级模板：代码生成 + 逐行解释
- ✅ 一键复制功能
- ✅ 邮箱订阅（每周获取新模板）
- ✅ 响应式设计
- ✅ 无需登录即可使用

### 为什么构建？
根据 Hacker News 和 Medium 的调研：
- Cursor AI 工具达到 80%+ 采用率
- 提示词维护是 AI 产品的关键痛点（"维持比编写更重要"）
- 市场定价：$10-50/月是主流区间

### 技术栈
- 前端：HTML + Tailwind CSS
- 部署：Vercel / Netlify
- 代码：~370 行，2 小时构建

### MVP 特点
- ⚡ 快速构建（2 小时）
- 🎯 功能优先（复制 > 美观）
- 💡 从个人需求出发
- 📊 简单验证（邮件收集）

---

## 🎯 发布渠道策略

### Product Hunt
**发布时间**：UTC 2026-02-02 14:00（北京时间 22:00）

**发布内容**：
- [x] 产品标题：PromptMaster - AI 提示词模板库
- [x] 产品介绍
- [x] 主要功能列表
- [x] 免费 vs 付费说明
- [x] 为什么构建（技术栈）
- [x] 演示 GIF 或截图
- [x] 邮箱订阅链接

**发布后准备**：
- 第 1 小时：回复所有评论
- 第 2-4 小时：主动联系相关创作者
- 第 24 小时：总结反馈和调整

### Hacker News (Show HN)
**标题**：Show HN: I built an AI prompt template library to solve the "prompt maintenance" problem

**内容**：
```
I've built PromptMaster, a free AI prompt template library with 500+ templates.

The problem: Cursor AI tools show 80%+ adoption rates, but "prompt maintenance is harder than writing" is a major pain point.

What it does:
- 5 free templates (code review, content writing, email, data analysis, research)
- 1 premium template (code gen + explanation)
- One-click copy
- Email subscription for weekly updates
- Responsive design
- No login required

Tech stack: HTML + Tailwind, built in 2 hours

Goal: First paying user by day 7.

Feedback welcome!
```

**发布时间**：UTC 2026-02-02 15:00（北京时间 23:00）

### Twitter/X
**标签**：#AITools #PromptEngineering #SideProject #IndieHacker

**推文模板 1**：
```
🚀 Just launched PromptMaster - Free AI prompt template library

500+ templates to boost your AI productivity
Solve the "prompt maintenance" problem

🔗 https://raye-deng.github.io/promptmaster/

#AITools #PromptEngineering #IndieHacker
```

**推文模板 2**（发布后）：
```
📊 Launch Day Stats:
- 2 hours to build
- 370 lines of code
- 5 free templates ready

Goal: First paying user by day 7

Feedback? 👇
#AITools #PromptEngineering
```

### Reddit
**Subreddits**：
- r/artificial - AI 工具
- r/SideProject - 独立项目
- r/SaaS - SaaS 产品

**发布模板**：
```
Title: [Launched] PromptMaster - AI Prompt Template Library

I've built a free AI prompt template library with 500+ templates to help developers and content creators.

The Problem:
After researching Hacker News and Medium, I found that "prompt maintenance" is harder than writing for AI products.

Features:
- 5 free templates (code review, content writing, email, data analysis, research)
- 1 premium template preview
- One-click copy
- Email subscription
- Responsive design
- No login required

Tech: HTML + Tailwind CSS, built in 2 hours

Live Demo: https://raye-deng.github.io/promptmaster/

Goal: First paying user by day 7.

Would love your feedback!

#AITools #SideProject #SaaS
```

---

## 📊 发布后跟踪指标

### 第 1 小时
- [ ] 访问量（Analytics）
- [ ] 评论数
- [ ] upvotes (Product Hunt, Reddit)
- [ ] 邮件订阅数

### 第 24 小时
- [ ] 总访问量
- [ ] 邮件订阅增长
- [ ] 第一个付费用户？
- [ ] 用户反馈汇总

### 第 7 天
- [ ] 付费用户数
- [ ] MRR（月度经常性收入）
- [ ] 最热门模板（使用率）
- [ ] 成功/失败分析

---

## 🔄 迭代计划

### 如果获得第一个付费用户（7 天内）
1. ✅ 添加更多免费模板（目标 20+）
2. ✅ 实现支付集成（Stripe）
3. ✅ 添加用户账户系统
4. ✅ 创建高级模板包（$19/月）

### 如果零付费用户（7 天后）
1. 🔍 分析原因：
   - 模板质量不够？
   - 需求不真实？
   - 分发渠道不对？
   - 定价有问题？
2. 🔄 转向策略：
   - 添加更多使用场景（如营销、教育）
   - 改进 UX/UI
   - 考虑完全免费模式
3. 📢 发布新版本：V2.0 with lessons learned

---

*准备就绪，等待部署完成后执行*