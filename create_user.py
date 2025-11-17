import ckan.model as model
from ckan.common import config

# Load config
from ckan.cli import load_config
conf = load_config('test-core-ci.ini')

# Initialize model
model.repo.init_db()

# Check if user exists
existing_user = model.User.get('admin')
if existing_user:
    print("User 'admin' already exists!")
    existing_user.sysadmin = True
    model.Session.commit()
    print("User 'admin' is now a sysadmin!")
else:
    # Create user
    user = model.User(name='admin', email='admin@localhost', password='admin123')
    model.Session.add(user)
    model.Session.commit()
    user.sysadmin = True
    model.Session.commit()
    print("Admin user created successfully!")
