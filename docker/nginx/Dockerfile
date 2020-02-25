FROM nginx:1.17.8-alpine
RUN rm -f /etc/nginx/conf.d/*
COPY my_bookshelf.conf /etc/nginx/conf.d/my_bookshelf.conf
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
