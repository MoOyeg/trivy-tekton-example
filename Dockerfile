FROM quay.io/mooyeg/python3 

# # Install the required software
# RUN yum update -y && yum install git python3 -y

# # Install pip
# RUN curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && python3 get-pip.py

#Make Application Directory
RUN mkdir ./app && cd ./app

# Copy Files into containers
COPY ./ ./app

#WORKDIR
WORKDIR /app

# Install App Dependecies
RUN pip install -r requirements.txt

#Expose Ports
EXPOSE 8080/tcp

#Change Permissions to allow not root-user work
RUN chmod -R g+rw ./

#Change User
USER 1001

#ENTRY
#ENTRYPOINT gunicorn -c $APP_CONFIG $APP_MODULE
ENTRYPOINT gunicorn -b localhost:8080 -w 1 $APP_MODULE