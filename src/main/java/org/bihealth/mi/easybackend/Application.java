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

package org.bihealth.mi.easybackend;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * This class is the main entry point for the easybackend service.
 * 
 * @author Felix Wirth
 *
 */
@SpringBootApplication
public class Application {
	
	/** Logger. */
	private static Logger LOGGER = LoggerFactory.getLogger(Application.class);
	
	/**
	 * The entry point.
	 * Starts the database-controller and the controller for the REST-API.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		// Starting the application.
		SpringApplication.run(Application.class, args);
		
		// Finished start-up
		LOGGER.info("Start up procedure completed. Waiting for requests ...");
	}
}