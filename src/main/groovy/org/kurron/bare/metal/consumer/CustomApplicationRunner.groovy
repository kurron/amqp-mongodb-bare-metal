package org.kurron.bare.metal.consumer

import groovy.util.logging.Slf4j
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.ApplicationArguments
import org.springframework.boot.ApplicationRunner
import org.springframework.data.mongodb.core.MongoOperations

/**
 * Run as the application is starting.
 */
@Slf4j
class CustomApplicationRunner implements ApplicationRunner {

    @Autowired
    private MongoOperations theTemplate
    @Override
    void run( ApplicationArguments args ) {

        log.info( 'Dropping the Model collection' )
        theTemplate.dropCollection( Model )

    }
}
