#!/bin/bash

IOS_CONFIG_PATH="./ShutterMac/Config.xcconfig"

setup_project() {
echo -e "\n 🚧 Setting up the project..."
source ./scripts/env.sh

echo -e "\n ⚒️ Creating Config.xcconfig..."
cat <<EOF > "$IOS_CONFIG_PATH"
PRODUCT_BUNDLE_IDENTIFIER=$BUNDLE_ID
PRODUCT_NAME=$PRODUCT_NAME
MARKETING_VERSION=$VERSION
CURRENT_PROJECT_VERSION=$BUILD
EOF

echo -e "\n✅ Setup Complete!"
}

# Run setup
setup_project
