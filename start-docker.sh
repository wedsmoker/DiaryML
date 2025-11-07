#!/bin/bash
# DiaryML Docker Startup Script
# Detects your local IP and starts Docker container

echo "============================================================"
echo "DiaryML - Docker Startup"
echo "============================================================"

# Detect local IP
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    LOCAL_IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    LOCAL_IP=$(ip route get 8.8.8.8 2>/dev/null | grep -oP 'src \K\S+')
fi

if [ -z "$LOCAL_IP" ]; then
    echo ""
    echo "⚠️  Could not auto-detect your local IP"
    echo "   Find it manually:"
    echo "   - Mac: System Preferences → Network"
    echo "   - Linux: ip addr show"
    echo ""
    read -p "Enter your local IP (e.g., 192.168.1.100): " LOCAL_IP
fi

echo ""
echo "Starting DiaryML Docker container..."
docker-compose up -d

echo ""
echo "============================================================"
echo "DiaryML is running!"
echo "============================================================"
echo ""
echo "  Desktop: http://localhost:8000"
echo "  Mobile:  http://$LOCAL_IP:8000/api"
echo ""
echo "  Enter the Mobile URL in your phone's DiaryML app"
echo "============================================================"
echo ""
echo "To stop: docker-compose down"
echo "To view logs: docker-compose logs -f diaryml"
