FROM hhcordero/docker-jmeter-server


ENV TEST_DIR /tmp
ENV TEST_PLAN test-plan.jmx
ENV REMOTE_HOSTS 127.0.0.1
RUN chmod g+rwx -R /usr/local/apache-jmeter-2.13/

COPY load_tests $TEST_DIR 
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
