#!/bin/bash

# PromptMaster GitHub + Vercel 部署脚本
# 使用 GitHub API 创建仓库，然后通过 Vercel Dashboard 部署

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 项目配置
PROJECT_NAME="prompt-templates-mvp"
BUILD_DIR="/Users/raye.deng/.openclaw/workspace/prompt-templates-mvp"
REPO_NAME="prompt-templates-mvp"
REPO_DESC="PromptMaster - AI 提示词模板库。500+ 免费模板，提升 AI 生产力。"

# 检查函数
check_command() {
    if command -v "$1" &> /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

echo -e "${GREEN}=== PromptMaster 部署脚本 ===${NC}"
echo ""

# 方案 1: GitHub API + Vercel Dashboard
if [ ! -z "$GITHUB_TOKEN" ]; then
    echo -e "${YELLOW}方案 1：GitHub + Vercel Dashboard${NC}"
    echo "=========================================="
    echo "这个方案需要 GitHub Personal Access Token"
    echo ""
    echo "获取步骤："
    echo "1. 访问 https://github.com/settings/tokens"
    echo "2. 点击 'Generate new token (classic)'"
    echo "3. 命名为 'prompt-master-deploy'"
    echo "4. 选择范围：'repo'（完整仓库访问权限）"
    echo "5. 选择过期时间：90 天或更长"
    echo "6. 点击 'Generate token'"
    echo "7. 复制生成的 token"
    echo ""
    echo "设置方法："
    echo "  export GITHUB_TOKEN='your-token-here'"
    echo ""
    echo "设置后，脚本将自动创建仓库！"
    echo ""

    if check_command curl; then
        # 创建 GitHub 仓库
        echo -e "${YELLOW}正在创建 GitHub 仓库...${NC}"

        RESPONSE=$(curl -s -X POST \
            -H "Authorization: token $GITHUB_TOKEN" \
            -H "Accept: application/vnd.github.v3+json" \
            -d "{
                \"name\": \"$REPO_NAME\",
                \"description\": \"$REPO_DESC\",
                \"private\": false,
                \"auto_init\": true
            }" \
            https://api.github.com/user/repos 2>&1)

        # 解析仓库名称
        REPO_URL=$(echo "$RESPONSE" | grep -o '"html_url":"[^"]*' | sed 's/.*"html_url":"\([^"]*\)".*/\1/')
        CLONE_URL=$(echo "$RESPONSE" | grep -o '"clone_url":"[^"]*' | sed 's/.*"clone_url":"\([^"]*\)".*/\1/')

        if [[ -n "$REPO_URL" ]]; then
            echo -e "${GREEN}✓ 仓库已创建！${NC}"
            echo ""
            echo "仓库地址："
            echo -e "${BLUE}$REPO_URL${NC}"
            echo ""
            echo "克隆地址："
            echo -e "${BLUE}$CLONE_URL${NC}"

            # 推送代码到 GitHub
            echo ""
            echo -e "${YELLOW}正在推送代码到 GitHub...${NC}"

            # 添加远程仓库（如果还不存在）
            if ! git remote | grep -q "origin"; then
                git remote add origin "$CLONE_URL"
            fi

            # 推送
            git push -u origin master 2>&1

            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ 代码已推送到 GitHub！${NC}"
                echo ""
                echo "=========================================="
                echo "📋 下一步："
                echo ""
                echo "1. 访问你的 GitHub 仓库："
                echo "   $REPO_URL"
                echo ""
                echo "2. 访问 Vercel Dashboard："
                echo "   https://vercel.com/new"
                echo ""
                echo "3. 点击 'Import'，选择 Git："
                echo "   输入仓库 URL: $CLONE_URL"
                echo "   或直接选择：[你的用户名]/prompt-templates-mvp"
                echo ""
                echo "4. Vercel 会自动检测并部署"
                echo ""
                echo "5. 部署完成后，你将获得一个 URL，如："
                echo "   https://prompt-master-[random].vercel.app"
                echo ""
                echo "6. 更新 launch-checklist.md 中的 URL"
                echo ""
                echo -e "${GREEN}🚀 准备发布到社区！${NC}"
            else
                echo -e "${RED}✗ 推送失败${NC}"
                echo "请检查 Git 配置和网络连接"
            fi
        else
            echo -e "${RED}✗ 创建仓库失败${NC}"
            echo "请检查："
            echo "- GitHub token 是否有效"
            echo "- 网络连接是否正常"
            echo "- 仓库名称是否已存在"
        fi
    else
        echo -e "${YELLOW}未设置 GITHUB_TOKEN${NC}"
        echo ""
        echo "请先获取并设置 GitHub token："
        echo "1. 访问 https://github.com/settings/tokens"
        echo "2. 点击 'Generate new token (classic)'"
        echo "3. 命名为 'prompt-master-deploy'"
        echo "4. 选择范围：'repo'（完整仓库访问权限）"
        echo "5. 点击 'Generate token'"
        echo "6. 复制生成的 token"
        echo ""
        echo "设置方法："
        echo "  export GITHUB_TOKEN='your-token-here'"
        echo ""
        echo "设置后，重新运行此脚本"
fi

echo ""
echo -e "${GREEN}=== 脚本完成 ===${NC}"
