sudo apt update

sudo apt install -y \
git \
nginx \
python3 \
python3-venv \
python3-pip \
nodejs \
npm
sudo mkdir -p /var/www
cd /var/www

sudo git clone https://github.com/YOUR_USERNAME/flask-react-template.git flask-react-app
sudo chmod +x deploy.sh

flask-react-template/
│
├── backend/
├── frontend/
│
├── deploy.sh
├── nginx.conf (or snippet)
│
└── .github/
    └── workflows/
        └── deploy.yml