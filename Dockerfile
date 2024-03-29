FROM python:3.7.4-slim-stretch
ARG version=0.0.0

LABEL maintainer="tom@altobyte.io"
LABEL version="${version}"
LABEL "com.example.vendor"="altobyte"
LABEL description="Generates OpenVPN Config File (ovpn), \
cert and keys must exisit in /etc/openvpn/pki/"

RUN mkdir -p /data /procudo
ADD README.md /
ADD setup.py /
ADD requirements.txt /
ADD procudo/ /procudo


RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
# RUN python setup.py sdist bdist_wheel
RUN python setup.py bdist_wheel
RUN pip install dist/procudo-${version}-py3-none-any.whl

ENTRYPOINT [ "gunicorn" ]
CMD [ "-b","0.0.0.0:8000", "-w", "4", "procudo:app" ]
