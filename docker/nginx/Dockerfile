FROM nginx:1.19.6

LABEL maintainer="OUSSAMA KHACHIAI <oussama.khachiai@gmail.com>"

COPY nginx.conf /etc/nginx/
COPY application.conf /etc/nginx/conf.d/default.conf

RUN echo "upstream php-upstream { server phpfpm:9001; }" > /etc/nginx/conf.d/upstream.conf

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
