FROM python:3.6
LABEL maintainer="zeddyu.lu@gmail.com"
COPY ./src /app
WORKDIR /app
RUN pip install flask flask_socketio flask_restful eventlet gunicorn==20.0.4 gevent
EXPOSE 6767
CMD [ "gunicorn","--keep-alive", "10", "-k","gevent","--bind", "0.0.0.0:6767","-w","4","app:app" ]
# ENTRYPOINT ["gunicorn --keep-alive 10 -k gevent --bind 0.0.0.0:6767 -w 4 app:app"]