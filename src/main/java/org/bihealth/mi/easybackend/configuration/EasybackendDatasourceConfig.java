/* 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.bihealth.mi.easybackend.configuration;

import org.jooq.DSLContext;
import org.jooq.SQLDialect;
import org.jooq.impl.DataSourceConnectionProvider;
import org.jooq.impl.DefaultConfiguration;
import org.jooq.impl.DefaultDSLContext;
import org.jooq.impl.DefaultExecuteListenerProvider;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.autoconfigure.jooq.JooqExceptionTranslator;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.TransactionAwareDataSourceProxy;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariDataSource;

/**
 * Class to configure data source
 * 
 * @author Felix Wirth
 *
 */
@Configuration(proxyBeanMethods = false)
@EnableTransactionManagement
@Component
public class EasybackendDatasourceConfig {

    /**
     * Create new easybackend data source properties.
     *
     * @return the data source properties
     */
    @Bean(name = "easybackendDataSourceProperties")
    @ConfigurationProperties(prefix = "app.datasource.easybackend")
    public DataSourceProperties easybackendDataSourceProperties() {
        return new DataSourceProperties();
    }

    /**
     * Create a new Hikari data source for the easybackend service.
     *
     * @param dataSourceProperties the properties for the data source
     * @return the Hikari data source
     */
    @Bean(name = "easybackendDataSource")
    @ConfigurationProperties(prefix = "app.datasource.easybackend.configuration")
    public HikariDataSource easybackendDataSource(@Qualifier("easybackendDataSourceProperties") DataSourceProperties dataSourceProperties) {
        return dataSourceProperties.initializeDataSourceBuilder().type(HikariDataSource.class).build();
    }

    /**
     * Create a new data source connection provider.
     *
     * @param dataSource the data source
     * @return the data source connection provider
     */
    @Bean
    public DataSourceConnectionProvider easybackendConnectionProvider(@Qualifier("easybackendDataSource") HikariDataSource dataSource) {
        return new DataSourceConnectionProvider(new TransactionAwareDataSourceProxy(dataSource));
    }

    /**
     * Create a new domain-specific language (DSL) context.
     *
     * @param dataSource the data source
     * @return the dsl context
     */
    @Bean(name = "easybackendDsl")
    public DSLContext easybackendDsl(@Qualifier("easybackendDataSource") HikariDataSource dataSource) {
        return new DefaultDSLContext(easybackendConfiguration(dataSource));
    }

    /**
     * Create a new default configuration for the easybackend service.
     *
     * @param dataSource the data source
     * @return the default configuration
     */
    public DefaultConfiguration easybackendConfiguration(@Qualifier("easybackendDataSource") HikariDataSource dataSource) {
        DefaultConfiguration config = new DefaultConfiguration();
        config.set(easybackendConnectionProvider(dataSource));
        config.set(SQLDialect.POSTGRES);
        config.set(new DefaultExecuteListenerProvider(new JooqExceptionTranslator()));
        return config;
    }
}
