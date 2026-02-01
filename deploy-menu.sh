#!/bin/bash

# PromptMaster 统一部署脚本
# 让用户选择部署方案：Netlify, GitHub+Vercel, 或 GitHub Pages

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 项目路径
SCRIPT_DIR="/Users/raye.deng/.openclaw/workspace/prompt-templates-mvp"
cd "$SCRIPT_DIR"

echo -e "${CYAN}
╔════════════════════════════════════════════╗
║                                                        ║
║   ${GREEN}PromptMaster${NC} ${YELLOW}自动部署工具${NC}               ║
║                                                        ║
╚══════════════════════════════════════════════╝${NC}
"
echo ""

# 显示菜单
show_menu() {
    echo -e "${YELLOW}请选择部署方案：${NC}"
    echo ""
    echo "  ${GREEN}1)${NC} Netlify API 自动部署（推荐，最快）"
    echo "      ${CYAN}需要: Netlify Personal Access Token"
    echo "      ${BLUE}时间: ~2 分钟（创建站点 + 上传）"
    echo "      ${GREEN}优点:${NC} 无需手动操作，完全自动化"
    echo ""
    echo "  ${GREEN}2)${NC} GitHub API + Vercel Dashboard"
    echo "      ${CYAN}需要: GitHub Personal Access Token"
    echo "      ${BLUE}时间: ~3 分钟（创建仓库 + 推送）"
    echo "      ${GREEN}优点:${NC} 可视化管理，持续部署"
    echo ""
    echo "  ${GREEN}3)${NC} GitHub Pages（免费，稳定）"
    echo "      ${CYAN}需要: GitHub 仓库"
    echo "      ${BLUE}时间: ~5 分钟（启用 Pages + 首次部署）"
    echo "      ${GREEN}优点:${NC} 完全免费，无需额外配置"
    echo ""
    echo "  ${YELLOW}4)${NC} 查看详细说明"
    echo ""
    echo "  ${RED}0)${NC} 退出"
    echo ""
    echo -e "${YELLOW}你的选择: [1-4]: ${NC} "
    read -r choice
}

# 获取 Token（需要时）
get_netlify_token() {
    echo -e "${YELLOW}获取 Netlify Token 说明：${NC}"
    echo "1. 访问 https://app.netlify.com/user/applications"
    echo "2. 点击 'New access token'"
    echo "3. 名称填入：prompt-master-deploy"
    echo "4. 选择 'Personal access'"
    echo "5. 点击 'Generate token'"
    echo "6. 复制生成的 token"
    echo ""
    echo -e "${GREEN}设置命令：${NC} export NETLIFY_TOKEN='your-token-here'"
    echo ""
    echo -e "${CYAN}按 Enter 继续...${NC}"
    read
}

get_github_token() {
    echo -e "${YELLOW}获取 GitHub Token 说明：${NC}"
    echo "1. 访问 https://github.com/settings/tokens"
    echo "2. 点击 'Generate new token (classic)'"
    echo "3. 名称填入：prompt-master-deploy"
    echo "4. 选择过期时间：90 days 或 No expiration"
    echo "5. 勾选 'repo'（完整仓库访问）"
    echo "6. 点击 'Generate token'"
    echo "7. 复制生成的 token（只显示一次）"
    echo ""
    echo -e "${GREEN}设置命令：${NC} export GITHUB_TOKEN='your-token-here'"
    echo ""
    echo -e "${CYAN}⚠️  注意：token 只显示一次，请立即保存！${NC}"
    echo ""
    echo -e "${YELLOW}按 Enter 继续...${NC}"
    read
}

# 执行部署
execute_deployment() {
    local choice=$1

    case $choice in
        1)
            echo -e "${GREEN}=== 方案 1：Netlify API 自动部署 ===${NC}"
            echo ""

            # 检查 Token
            if [ -z "$NETLIFY_TOKEN" ]; then
                get_netlify_token
            fi

            # 执行部署
            bash deploy.sh
            ;;

        2)
            echo -e "${GREEN}=== 方案 2：GitHub API + Vercel Dashboard ===${NC}"
            echo ""

            # 检查 Token
            if [ -z "$GITHUB_TOKEN" ]; then
                get_github_token
            fi

            # 执行部署
            bash deploy-github-vercel.sh
            ;;

        3)
            echo -e "${GREEN}=== 方案 3：GitHub Pages ===${NC}"
            echo ""
            echo -e "${YELLOW}手动步骤说明：${NC}"
            echo ""
            echo "1. 如果还没有 GitHub 仓库，请先创建："
            echo "   访问 https://github.com/new"
            echo "   仓库名称：prompt-templates-mvp"
            echo "   选择 Public"
            echo "   点击 'Create repository'"
            echo ""
            echo "2. 推送代码到仓库："
            echo "   cd prompt-templates-mvp"
            echo "   git add ."
            echo "   git commit -m 'Deploy to GitHub Pages'"
            echo "   git remote add origin https://github.com/[你的用户名]/prompt-templates-mvp.git"
            echo "   git push -u origin master"
            echo ""
            echo "3. 启用 GitHub Pages："
            echo "   访问仓库 Settings → Pages"
            echo "   选择 'main' 或 'master' 分支作为源"
            echo "   点击 'Save'"
            echo ""
            echo "4. 访问地址："
            echo "   https://[你的用户名].github.io/prompt-templates-mvp/"
            echo ""
            echo -e "${CYAN}部署完成后，更新 launch-checklist.md 中的 URL！${NC}"
            ;;

        4)
            echo -e "${GREEN}=== 详细说明 ===${NC}"
            echo ""
            echo "📋 方案对比："
            echo ""
            echo "${BLUE}方案 1：Netlify API${NC}"
            echo "  - 需要配置：NETLIFY_TOKEN"
            echo "  - 部署时间：~2 分钟"
            echo "  - URL 格式：https://promptmaster.netlify.app"
            echo "  - 自动化程度：100%"
            echo ""
            echo "${BLUE}方案 2：GitHub + Vercel${NC}"
            echo "  - 需要配置：GITHUB_TOKEN"
            echo "  - 部署时间：~3 分钟"
            echo "  - URL 格式：https://prompt-master-[随机].vercel.app"
            echo "  - 自动化程度：90%（创建仓库需手动操作）"
            echo ""
            echo "${BLUE}方案 3：GitHub Pages${NC}"
            echo "  - 需要配置：GITHUB_TOKEN（仅用于创建仓库）"
            echo "  - 部署时间：~5 分钟"
            echo "  - URL 格式：https://[用户名].github.io/prompt-templates-mvp/"
            echo "  - 自动化程度：80%（Pages 启用和首次推送需手动）"
            echo ""
            echo "${YELLOW}推荐：方案 1（Netlify API）最快且最自动化${NC}"
            ;;

        0)
            echo -e "${GREEN}退出${NC}"
            exit 0
            ;;

        *)
            echo -e "${RED}无效选择，请重新运行${NC}"
            exit 1
            ;;
    esac
}

# 主循环
while true; do
    show_menu
    execute_deployment "$choice"

    # 询问是否继续
    echo ""
    echo -e "${YELLOW}是否继续部署其他方案？(y/n)${NC} "
    read -r continue

    if [[ "$continue" != "y" && "$continue" != "Y" ]]; then
        break
    fi
done

echo ""
echo -e "${GREEN}部署完成！${NC}"
echo ""
echo -e "${YELLOW}下一步：${NC}"
echo "1. 访问你的 PromptMaster 网站"
echo "2. 发布到 Product Hunt, Hacker News, Twitter/X, Reddit"
echo "3. 收集用户反馈"
echo ""
echo -e "${CYAN}祝发布顺利！🚀${NC}"
