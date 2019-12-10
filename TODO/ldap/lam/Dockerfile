FROM php:7.2-fpm-alpine

COPY install_lam.sh entrypoint /wwwroot/

# ENV LANG=zh_CN.UTF-8 \
#     LANGUAGE=zh_CN:en_US:en \
ENV TZ=Asia/Shanghai

RUN  /wwwroot/install_lam.sh

CMD ["/wwwroot/entrypoint"]
