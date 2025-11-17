#!/bin/bash
# Script to create CKAN admin user in Docker container

cd /usr/src/ckan

# Create admin user using Python
python << 'EOF'
import ckan.model as model

# Initialize database connection
model.repo.init_db()

# Check if user already exists
existing_user = model.User.get('admin')
if existing_user:
    print("User 'admin' already exists!")
    print("Setting as sysadmin...")
    existing_user.sysadmin = True
    model.Session.commit()
    print("User 'admin' is now a sysadmin!")
else:
    # Create new user
    user = model.User(
        name='admin',
        email='admin@localhost',
        password='admin123'
    )
    model.Session.add(user)
    model.Session.commit()
    
    # Make user sysadmin
    user.sysadmin = True
    model.Session.commit()
    
    print("Admin user created successfully!")
    print("Username: admin")
    print("Password: admin123")
    print("Email: admin@localhost")
EOF

