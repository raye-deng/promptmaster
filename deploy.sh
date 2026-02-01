#!/bin/bash

# PromptMaster 自动部署脚本
# 使用 Netlify API 或 GitHub API 自动部署

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 项目配置
PROJECT_NAME="prompt-templates-mvp"
BUILD_DIR="/Users/raye.deng/.openclaw/workspace/prompt-templates-mvp"

# 检查函数
check_command() {
    if command -v "$1" &> /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

echo -e "${GREEN}=== PromptMaster 自动部署脚本 ===${NC}"
echo ""

# 方案 1: Netlify API 部署（推荐）
if [ ! -z "$NETLIFY_TOKEN" ]; then
    echo -e "${YELLOW}方案 1：Netlify API 部署${NC}"
    echo "====================================="
    echo "这个方案需要 Netlify Personal Access Token"
    echo ""
    echo "获取步骤："
    echo "1. 访问 https://app.netlify.com/user/applications"
    echo "2. 点击 'New access token'"
    echo "3. 命名为 'prompt-master-deploy'"
    echo "4. 选择 'Personal access'"
    echo "5. 复制生成的 token"
    echo ""
    echo "设置方法："
    echo "  export NETLIFY_TOKEN='your-token-here'"
    echo ""
    echo "设置后，脚本将自动部署！"
    echo ""

    if check_command curl; then
        # 测试 API 连接
        RESPONSE=$(curl -s -H "Authorization: Bearer $NETLIFY_TOKEN" \
            -H "Content-Type: application/json" \
            https://api.netlify.com/api/v1/user | head -1)

        if [[ "$RESPONSE" == *"\"id\""* ]]; then
            echo -e "${GREEN}✓ Netlify token 有效！${NC}"
            echo ""

            # 部署函数
            deploy_with_netlify() {
                echo -e "${YELLOW}正在部署到 Netlify...${NC}"

                # 创建站点
                SITE_ID=$(curl -s -X POST \
                    -H "Authorization: Bearer $NETLIFY_TOKEN" \
                    -H "Content-Type: application/json" \
                    -d "{
                        \"name\": \"promptmaster\",
                        \"account_slug\": \"$NETLIFY_ACCOUNT_ID\"
                    }" \
                    https://api.netlify.com/api/v1/sites | grep -o '"id":"[^"]*' | head -1)

                if [ -z "$SITE_ID" ]; then
                    echo -e "${RED}✗ 创建站点失败${NC}"
                    return 1
                fi

                echo -e "${GREEN}✓ 站点已创建，ID: $SITE_ID${NC}"

                # 创建部署（使用 dir deploy）
                echo "正在上传文件..."

                # 使用 tar 压缩
                cd "$BUILD_DIR"
                tar -czf ../site.tar.gz .

                # 上传
                DEPLOY_ID=$(curl -s -X POST \
                    -H "Authorization: Bearer $NETLIFY_TOKEN" \
                    -H "Content-Type: application/octet-stream" \
                    --data-binary @../site.tar.gz \
                    "https://api.netlify.com/api/v1/sites/$SITE_ID/deploys" | grep -o '"id":"[^"]*' | head -1)

                if [ -n "$DEPLOY_ID" ]; then
                    echo -e "${GREEN}✓ 部署完成！${NC}"
                    echo ""
                    echo "访问地址："
                    echo -e "${GREEN}https://promptmaster.netlify.app${NC}"
                    echo ""
                    echo "部署 ID：$DEPLOY_ID"

                    # 保存部署信息
                    echo "NETLIFY_URL=https://promptmaster.netlify.app" > "$BUILD_DIR/.deploy-info"
                    echo "DEPLOY_ID=$DEPLOY_ID" >> "$BUILD_DIR/.deploy-info"
                    echo "DEPLOY_TIME=$(date -u '+%Y-%m-%d %H:%M:%S')" >> "$BUILD_DIR/.deploy-info"
                else
                    echo -e "${RED}✗ 部署失败${NC}"
                    return 1
                fi

                # 清理
                cd "$BUILD_DIR/.."
                rm -f site.tar.gz
            }

            deploy_with_netlify
            return 0
        else
            echo -e "${RED}✗ curl 命令不可用${NC}"
            echo "请安装 curl: brew install curl"
            return 1
        fi
    fi
else
    echo -e "${YELLOW}未设置 NETLIFY_TOKEN${NC}"
    echo ""
    echo "请先获取并设置 Netlify token："
    echo "1. 访问 https://app.netlify.com/user/applications"
    echo "2. 创建 token 并运行：export NETLIFY_TOKEN='your-token-here'"
    echo "3. 然后重新运行此脚本"
fi

echo ""
echo -e "${GREEN}=== 部署完成 ===${NC}"
echo ""
echo "提示："
echo "- 访问 https://promptmaster.netlify.app（部署后）"
echo "- 发布到 Product Hunt, Hacker News, Twitter/X, Reddit"
echo "- 收集用户反馈"
