(ns burning_ideas.test.core
  (:use [burning_ideas.core])
  (:use [clojure.test]))

(deftest root-path-redirection
  (let [response (main-routes {:request-method :get :uri "/"})]
    (is (= 301 (:status response)))
    (is (= "/index.html" (get (:headers response) "Location")))))
