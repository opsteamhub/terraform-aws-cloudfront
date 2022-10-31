variable "cloudfront_distribution_config" {
  description = "Variable to define Cloud Front Distribution configs"
  type = list(
    object(
      {
        id      = string
        aliases = optional(set(string))   # Extra CNAMEs (alternate domain names), if any, for this distribution.
        comment = optional(string)        #  Any comments you want to include about the distribution.
        custom_error_response = optional( #  One or more custom error response elements (multiples allowed).
          set(
            object(
              {
                error_caching_min_ttl = optional(string) # The minimum amount of time you want HTTP error codes to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated.
                error_code            = optional(string) # The 4xx or 5xx HTTP status code that you want to customize.
                response_code         = optional(string) #  The HTTP status code that you want CloudFront to return with the custom error page to the viewer.
                response_page_path    = optional(string) # The path of the custom error page (for example, /custom_404.html).
              }
            )
          )
        )
        default_cache_behavior = object( #  The default cache behavior for this distribution (maximum one).
          {
            allowed_methods = optional(set(string)) #  Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin.
            cached_methods  = optional(set(string)) # Controls whether CloudFront caches the response to requests using the specified HTTP methods.
            cache_policy = optional(
              object(
                {
                  name        = optional(string) # A unique name to identify the cache policy.
                  comment     = optional(string) # A comment to describe the cache policy.
                  default_ttl = optional(string) # The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
                  id          = optional(string) # The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
                  max_ttl     = optional(string) # The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
                  min_ttl     = optional(string)
                  parameters_in_cache_key_and_forwarded_to_origin = optional( # The HTTP headers, cookies, and URL query strings to include in the cache key
                    object(
                      {
                        cookies_config = optional( # Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the cache key and automatically included in requests that CloudFront sends to the origin. 
                          object(
                            {
                              cookie_behavior = optional(string) # Determines whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
                              cookies = optional(                # Object that contains a list of cookie names.
                                object(
                                  {
                                    items = optional(set(string)) #  A list of item names (cookies, headers, or query strings).
                                  }
                                )
                              )
                            }
                          )
                        )
                        headers_config = optional( #  Object that determines whether any HTTP headers (and if so, which headers) are included in the cache key and automatically included in requests that CloudFront sends to the origin. 
                          object(
                            {
                              header_behavior = optional(string) # Determines whether any HTTP headers are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist.
                              headers = optional(                # Object that contains a list of header names.
                                object(
                                  {
                                    items = optional(set(string)) # A list of item names (cookies, headers, or query strings).
                                  }
                                )
                              )
                            }
                          )
                        )
                        query_strings_config = optional( # Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the cache key and automatically included in requests that CloudFront sends to the origin.
                          object(
                            {
                              query_string_behavior = optional(string) #  Determines whether any URL query strings in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
                              query_strings = optional(                # Object that contains a list of query string names.
                                object(
                                  {
                                    items = optional(set(string)) # A list of item names (cookies, headers, or query strings).
                                  }
                                )
                              )
                            }
                          )
                        )
                      }
                    )
                  )
                }
              )
            )
            compress                  = optional(bool)   # Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false).
            default_ttl               = optional(string) # The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header.
            field_level_encryption_id = optional(string) # Field level encryption configuration ID
            forwarded_values = optional(                 #  The forwarded values configuration that specifies how CloudFront handles query strings, cookies and headers (maximum one).
              object(
                {
                  cookies = optional( # The forwarded values cookies that specifies how CloudFront handles cookies (maximum one).
                    object(
                      {
                        forward           = optional(string)      # Whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names
                        whitelisted_names = optional(set(string)) # If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin.
                      }
                    )
                  )
                  headers                 = optional(set(string)) # Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers.
                  query_string            = optional(bool)        #  Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior.
                  query_string_cache_keys = optional(set(string)) # When specified, along with a value of true for query_string, all query strings are forwarded, however only the query string keys listed in this argument are cached. When omitted with a value of true for query_string, all query string keys are cached.
                }
              )
            )
            function_association = optional( #  A config block that triggers a cloudfront function with specific actions (maximum 2).
              set(
                object(
                  {
                    event_type   = optional(string) # The specific event to trigger this function. Valid values: viewer-request or viewer-response
                    function_arn = optional(string) # ARN of the Cloudfront function.
                  }
                )
              )
            )
            lambda_function_association = optional( # A config block that triggers a lambda function with specific actions (maximum 4).
              set(
                object(
                  {
                    event_type   = optional(string) # The specific event to trigger this function. Valid values: viewer-request, origin-request, viewer-response, origin-response
                    lambda_arn   = optional(string) # ARN of the Lambda function
                    include_body = optional(string) # When set to true it exposes the request body to the lambda function. Defaults to false. Valid values: true, false.
                  }
                )
              )
            )
            max_ttl = optional(string) # The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers.
            min_ttl = optional(string) #  The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds.
            origin_request_policy = optional(
              object(
                {
                  id      = optional(string)
                  comment = optional(string) # Comment to describe the origin request policy.
                  cookies_config = optional( # Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the origin request key and automatically included in requests that CloudFront sends to the origin. 
                    object(
                      {
                        cookie_behavior = optional(string) # Determines whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
                        cookies = optional(                # Object that contains a list of cookie names. 
                          object(
                            {
                              items = optional(set(string)) # A list of item names (cookies, headers, or query strings).
                            }
                          )
                        )
                      }
                    )
                  )
                  headers_config = optional( # Object that determines whether any HTTP headers (and if so, which headers) are included in the origin request key and automatically included in requests that CloudFront sends to the origin. 
                    object(
                      {
                        header_behavior = optional(string) # Determines whether any HTTP headers are included in the origin request key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allViewer, allViewerAndWhitelistCloudFront
                        headers = optional(                # Object that contains a list of header names. 
                          object(
                            {
                              items = optional(set(string)) # List of item names (cookies, headers, or query strings).
                            }
                          )
                        )
                      }
                    )
                  )
                  query_strings_config = optional( # Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the origin request key and automatically included in requests that CloudFront sends to the origin.
                    object(
                      {
                        query_string_behavior = optional(string) # Determines whether any URL query strings in viewer requests are included in the origin request key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, all. 
                        query_strings = optional(                # Object that contains a list of query string names. 
                          object(
                            {
                              items = optional(set(string)) # List of item names (cookies, headers, or query strings).
                            }
                          )
                        )
                      }
                    )
                  )
                }
              )
            )
            #realtime_log_config_arn        = optional(string)
            response_headers_policy = optional(
              object(
                {
                  comment = optional(string)
                  cors_config = optional( # A configuration for a set of HTTP response headers that are used for Cross-Origin Resource Sharing (CORS).
                    object(
                      {
                        access_control_allow_credentials = optional(bool) # A Boolean value that CloudFront uses as the value for the Access-Control-Allow-Credentials HTTP response header.
                        access_control_allow_headers = optional(          # Object that contains an attribute items that contains a list of HTTP header names that CloudFront includes as values for the Access-Control-Allow-Headers HTTP response header.
                          object(
                            {
                              items = optional(set(string))
                            }
                          )
                        )
                        access_control_allow_methods = optional( # Object that contains an attribute items that contains a list of HTTP methods that CloudFront includes as values for the Access-Control-Allow-Methods HTTP response header. Valid values: GET | POST | OPTIONS | PUT | DELETE | HEAD | ALL
                          object(
                            {
                              items = optional(set(string))
                            }
                          )
                        )
                        access_control_allow_origins = optional( #  Object that contains an attribute items that contains a list of origins that CloudFront can use as the value for the Access-Control-Allow-Origin HTTP response header.
                          object(
                            {
                              items = optional(set(string))
                            }
                          )
                        )
                        access_control_expose_headers = optional( # Object that contains an attribute items that contains a list of HTTP headers that CloudFront includes as values for the Access-Control-Expose-Headers HTTP response header.
                          object(
                            {
                              items = optional(set(string))
                            }
                          )
                        )
                        access_control_max_age_sec = optional(string) #  A number that CloudFront uses as the value for the Access-Control-Max-Age HTTP response header
                        origin_override            = optional(bool)   # A Boolean value that determines how CloudFront behaves for the HTTP response header.
                      }
                    )
                  )
                  custom_headers_config = optional( #  Object that contains an attribute items that contains a list of custom headers
                    set(
                      object(
                        {
                          header   = optional(string) # The HTTP response header name.
                          override = optional(bool)   #  Whether CloudFront overrides a response header with the same name received from the origin with the header specifies here.
                          value    = optional(string) # The value for the HTTP response header.
                        }
                      )
                    )
                  )
                  id = optional(string)
                  security_headers_config = optional( # A configuration for a set of security-related HTTP response headers.
                    object(
                      {
                        content_security_policy = optional( # The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header
                          object(
                            {
                              content_security_policy = optional(string) # The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header.
                              override                = optional(string) # Whether CloudFront overrides the Content-Security-Policy HTTP response header received from the origin with the one specified in this response headers policy.
                            }
                          )
                        )
                        content_type_options = optional( # Determines whether CloudFront includes the X-Content-Type-Options HTTP response header with its value set to nosniff. 
                          object(
                            {
                              override = optional(string) # Whether CloudFront overrides the X-Content-Type-Options HTTP response header received from the origin with the one specified in this response headers policy.
                            }
                          )
                        )
                        frame_options = optional( # Determines whether CloudFront includes the X-Frame-Options HTTP response header and the header’s value. 
                          object(
                            {
                              frame_option = optional(string) # The value of the X-Frame-Options HTTP response header. Valid values: DENY | SAMEORIGIN
                              override     = optional(string) # Whether CloudFront overrides the X-Frame-Options HTTP response header received from the origin with the one specified in this response headers policy.
                            }
                          )
                        )
                        referrer_policy = optional( # Determines whether CloudFront includes the Referrer-Policy HTTP response header and the header’s value. 
                          object(
                            {
                              referrer_policy = optional(string) # The value of the Referrer-Policy HTTP response header. Valid Values: no-referrer | no-referrer-when-downgrade | origin | origin-when-cross-origin | same-origin | strict-origin | strict-origin-when-cross-origin | unsafe-url
                              override        = optional(string) # Whether CloudFront overrides the Referrer-Policy HTTP response header received from the origin with the one specified in this response headers policy.
                            }
                          )
                        )
                        strict_transport_security = optional( # Determines whether CloudFront includes the Strict-Transport-Security HTTP response header and the header’s value. 
                          object(
                            {
                              access_control_max_age_sec = optional(string) # A number that CloudFront uses as the value for the max-age directive in the Strict-Transport-Security HTTP response header.
                              include_subdomains         = optional(string) # Whether CloudFront includes the includeSubDomains directive in the Strict-Transport-Security HTTP response header.
                              override                   = optional(string) # Whether CloudFront overrides the Strict-Transport-Security HTTP response header received from the origin with the one specified in this response headers policy.
                              preload                    = optional(string) # Whether CloudFront includes the preload directive in the Strict-Transport-Security HTTP response header.
                            }
                          )
                        )
                        xss_protection = optional( # Determine whether CloudFront includes the X-XSS-Protection HTTP response header and the header’s value. 
                          object(
                            {
                              mode_block = optional(string) # Whether CloudFront includes the mode=block directive in the X-XSS-Protection header.
                              override   = optional(string) # Whether CloudFront overrides the X-XSS-Protection HTTP response header received from the origin with the one specified in this response headers policy.
                              protection = optional(bool)   # A Boolean value that determines the value of the X-XSS-Protection HTTP response header. When this setting is true, the value of the X-XSS-Protection header is 1. When this setting is false, the value of the X-XSS-Protection header is 0.
                              report_uri = optional(string) # A reporting URI, which CloudFront uses as the value of the report directive in the X-XSS-Protection header. You cannot specify a report_uri when mode_block is true.
                            }
                          )
                        )
                      }
                    )
                  )
                  server_timing_headers_config = optional( # A configuration for enabling the Server-Timing header in HTTP responses sent from CloudFront. 
                    object(
                      {
                        enabled       = optional(string) # A Whether CloudFront adds the Server-Timing header to HTTP responses that it sends in response to requests that match a cache behavior that's associated with this response headers policy.
                        sampling_rate = optional(string) # A number 0–100 (inclusive) that specifies the percentage of responses that you want CloudFront to add the Server-Timing header to. Valid range: Minimum value of 0.0. Maximum value of 100.0.
                      }
                    )
                  )
                }
              )
            )
            smooth_streaming = optional(string) # Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior.
            target_origin_id = string           # The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior.
            #trusted_key_groups             = optional(string)
            #trusted_signers                = optional(string)
            viewer_protocol_policy = optional(string) # Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https.
          }
        )

        default_root_object = optional(string) # The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL.
        enabled             = optional(string) # Whether the distribution is enabled to accept end user requests for content.
        is_ipv6_enabled     = optional(bool)   # Whether the IPv6 is enabled for the distribution.
        http_version        = optional(string) # The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3 and http3. The default is http2.

        logging_config = optional( # The logging configuration that controls how logs are written to your distribution (maximum one).
          object(
            {
              bucket          = optional(string) # The Amazon S3 bucket to store the access logs in, for example, myawslogbucket.s3.amazonaws.com.
              include_cookies = optional(string) # Specifies whether you want CloudFront to include cookies in access logs (default: false).
              prefix          = optional(string) # An optional string that you want CloudFront to prefix to the access log filenames for this distribution, for example, myprefix/.
            }
          )
        )

        ordered_cache_behavior = optional( # An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0.
          list(
            object(
              {
                allowed_methods = optional(set(string)) # Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin.
                cached_methods  = optional(set(string)) # Controls whether CloudFront caches the response to requests using the specified HTTP methods.

                cache_policy = optional(
                  object(
                    {
                      name        = optional(string) # A unique name to identify the cache policy.
                      comment     = optional(string) # A comment to describe the cache policy.
                      default_ttl = optional(string) # The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
                      id          = optional(string)
                      max_ttl     = optional(string)                              # The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
                      min_ttl     = optional(string)                              # The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
                      parameters_in_cache_key_and_forwarded_to_origin = optional( # The HTTP headers, cookies, and URL query strings to include in the cache key.
                        object(
                          {
                            cookies_config = optional( # Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Cookies Config for more information.
                              object(
                                {
                                  cookie_behavior = optional(string) # Determines whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
                                  cookies = optional(                # Object that contains a list of cookie names. See Items for more information.
                                    object(
                                      {
                                        items = optional(set(string)) #  A list of item names (cookies, headers, or query strings).
                                      }
                                    )
                                  )
                                }
                              )
                            )
                            headers_config = optional( # Object that determines whether any HTTP headers (and if so, which headers) are included in the cache key and automatically included in requests that CloudFront sends to the origin. 
                              object(
                                {
                                  header_behavior = optional(string) # Determines whether any HTTP headers are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist.
                                  headers = optional(                # Object that contains a list of header names. See Items for more information.
                                    object(
                                      {
                                        items = optional(set(string)) #  A list of item names (cookies, headers, or query strings).
                                      }
                                    )
                                  )
                                }
                              )
                            )
                            query_strings_config = optional( # Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the cache key and automatically included in requests that CloudFront sends to the origin. See Query String Config for more information.
                              object(
                                {
                                  query_string_behavior = optional(string) # Determines whether any URL query strings in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allExcept, all.
                                  query_strings = optional(                # Object that contains a list of query string names
                                    object(
                                      {
                                        items = optional(set(string)) # A list of item names (cookies, headers, or query strings).
                                      }
                                    )
                                  )
                                }
                              )
                            )
                          }
                        )
                      )
                    }
                  )
                )
                compress                  = optional(bool)   # Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false).
                default_ttl               = optional(string) # The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated.
                field_level_encryption_id = optional(string) #  Field level encryption configuration ID
                forwarded_values = optional(                 # The forwarded values configuration that specifies how CloudFront handles query strings, cookies and headers (maximum one).
                  object(
                    {
                      cookies = optional( # The forwarded values cookies that specifies how CloudFront handles cookies (maximum one).
                        object(
                          {
                            forward           = optional(string)      # Whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names
                            whitelisted_names = optional(set(string)) #  If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin.
                          }
                        )
                      )
                      headers                 = optional(set(string)) # Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers.
                      query_string            = optional(bool)        #  Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior.
                      query_string_cache_keys = optional(set(string)) # When specified, along with a value of true for query_string, all query strings are forwarded, however only the query string keys listed in this argument are cached. When omitted with a value of true for query_string, all query string keys are cached.
                    }
                  )
                )
                function_association = optional( # A config block that triggers a cloudfront function with specific actions (maximum 2).
                  set(
                    object(
                      {
                        event_type   = optional(string) # The specific event to trigger this function. Valid values: viewer-request or viewer-response.
                        function_arn = optional(string) # ARN of the Cloudfront function.
                      }
                    )
                  )
                )
                lambda_function_association = optional( #  A config block that triggers a lambda function with specific actions (maximum 4).
                  set(
                    object(
                      {
                        event_type   = optional(string) # The specific event to trigger this function. Valid values: viewer-request, origin-request, viewer-response, origin-response.
                        lambda_arn   = optional(string) # ARN of the Lambda function.
                        include_body = optional(string) # When set to true it exposes the request body to the lambda function. Defaults to false. Valid values: true, false.
                      }
                    )
                  )
                )
                max_ttl = optional(string)        # The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers.
                min_ttl = optional(string)        # The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds.
                origin_request_policy = optional( # Item to creates a CloudFront origin request policy
                  object(
                    {
                      id      = optional(string)
                      comment = optional(string) #  Comment to describe the origin request policy.
                      cookies_config = optional( # Object that determines whether any cookies in viewer requests (and if so, which cookies) are included in the origin request key and automatically included in requests that CloudFront sends to the origin
                        object(
                          {
                            cookie_behavior = optional(string) # Determines whether any cookies in viewer requests are included in the origin request key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist all
                            cookies = optional(                # Object that contains a list of cookie names.
                              object(
                                {
                                  items = optional(set(string)) #  List of item names (cookies, headers, or query strings).
                                }
                              )
                            )
                          }
                        )
                      )
                      headers_config = optional( #  Object that determines whether any HTTP headers (and if so, which headers) are included in the origin request key and automatically included in requests that CloudFront sends to the origin
                        object(
                          {
                            header_behavior = optional(string) # Determines whether any HTTP headers are included in the origin request key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allViewer, allViewerAndWhitelistCloudFront
                            headers = optional(                # Object that contains a list of header names.
                              object(
                                {
                                  items = optional(set(string)) #  List of item names (cookies, headers, or query strings).
                                }
                              )
                            )
                          }
                        )
                      )
                      query_strings_config = optional( # Object that determines whether any URL query strings in viewer requests (and if so, which query strings) are included in the origin request key and automatically included in requests that CloudFront sends to the origin. 
                        object(
                          {
                            query_string_behavior = optional(string) # Determines whether any URL query strings in viewer requests are included in the origin request key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, all. query_strings - (Optional) Object that contains a list of query string names
                            query_strings = optional(                # Object that contains a list of query string names
                              object(
                                {
                                  items = optional(set(string)) #  List of item names (cookies, headers, or query strings).
                                }
                              )
                            )
                          }
                        )
                      )
                    }
                  )
                )
                path_pattern = optional(string) # The pattern (for example, images/*.jpg) that specifies which requests you want this cache behavior to apply to.
                #realtime_log_config_arn        = optional(string)   
                response_headers_policy = optional(
                  object(
                    {
                      comment = optional(string) #  A comment to describe the response headers policy. The comment cannot be longer than 128 characters.
                      cors_config = optional(    # A configuration for a set of HTTP response headers that are used for Cross-Origin Resource Sharing (CORS).
                        object(
                          {
                            access_control_allow_credentials = optional(bool) # A Boolean value that CloudFront uses as the value for the Access-Control-Allow-Credentials HTTP response header.
                            access_control_allow_headers = optional(          # Object that contains an attribute items that contains a list of HTTP header names that CloudFront includes as values for the Access-Control-Allow-Headers HTTP response header.
                              object(
                                {
                                  items = optional(set(string))
                                }
                              )
                            )
                            access_control_allow_methods = optional( # Object that contains an attribute items that contains a list of HTTP methods that CloudFront includes as values for the Access-Control-Allow-Methods HTTP response header. Valid values: GET | POST | OPTIONS | PUT | DELETE | HEAD | ALL
                              object(
                                {
                                  items = optional(set(string))
                                }
                              )
                            )
                            access_control_allow_origins = optional( # Object that contains an attribute items that contains a list of origins that CloudFront can use as the value for the Access-Control-Allow-Origin HTTP response header.
                              object(
                                {
                                  items = optional(set(string))
                                }
                              )
                            )
                            access_control_expose_headers = optional( # Object that contains an attribute items that contains a list of HTTP headers that CloudFront includes as values for the Access-Control-Expose-Headers HTTP response header.
                              object(
                                {
                                  items = optional(set(string))
                                }
                              )
                            )
                            access_control_max_age_sec = optional(string) # A number that CloudFront uses as the value for the Access-Control-Max-Age HTTP response header.
                            origin_override            = optional(bool)   # A Boolean value that determines how CloudFront behaves for the HTTP response header.
                          }
                        )
                      )
                      custom_headers_config = optional( # Object that contains an attribute items that contains a list of custom headers. 
                        set(
                          object(
                            {
                              header   = optional(string) # The HTTP response header name.
                              override = optional(bool)   # Whether CloudFront overrides a response header with the same name received from the origin with the header specifies here.
                              value    = optional(string) #  The value for the HTTP response header.
                            }
                          )
                        )
                      )
                      id = optional(string)
                      security_headers_config = optional( #  A configuration for a set of security-related HTTP response headers.
                        object(
                          {
                            content_security_policy = optional( # The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header.
                              object(
                                {
                                  content_security_policy = optional(string) # The policy directives and their values that CloudFront includes as values for the Content-Security-Policy HTTP response header.
                                  override                = optional(string) # Whether CloudFront overrides the Content-Security-Policy HTTP response header received from the origin with the one specified in this response headers policy.
                                }
                              )
                            )
                            content_type_options = optional( # Determines whether CloudFront includes the X-Content-Type-Options HTTP response header with its value set to nosniff.
                              object(
                                {
                                  override = optional(string) # Whether CloudFront overrides the X-Content-Type-Options HTTP response header received from the origin with the one specified in this response headers policy.
                                }
                              )
                            )
                            frame_options = optional( #  Determines whether CloudFront includes the X-Frame-Options HTTP response header and the header’s value
                              object(
                                {
                                  frame_option = optional(string) # The value of the X-Frame-Options HTTP response header. Valid values: DENY | SAMEORIGIN
                                  override     = optional(string) # Whether CloudFront overrides the X-Frame-Options HTTP response header received from the origin with the one specified in this response headers policy.
                                }
                              )
                            )
                            referrer_policy = optional( # Determines whether CloudFront includes the Referrer-Policy HTTP response header and the header’s value. 
                              object(
                                {
                                  referrer_policy = optional(string) # The value of the Referrer-Policy HTTP response header. Valid Values: no-referrer | no-referrer-when-downgrade | origin | origin-when-cross-origin | same-origin | strict-origin | strict-origin-when-cross-origin | unsafe-url
                                  override        = optional(string) # Whether CloudFront overrides the Referrer-Policy HTTP response header received from the origin with the one specified in this response headers policy.
                                }
                              )
                            )
                            strict_transport_security = optional( # Determines whether CloudFront includes the Strict-Transport-Security HTTP response header and the header’s value. 
                              object(
                                {
                                  access_control_max_age_sec = optional(string) #  A number that CloudFront uses as the value for the max-age directive in the Strict-Transport-Security HTTP response header.
                                  include_subdomains         = optional(string) #  Whether CloudFront includes the includeSubDomains directive in the Strict-Transport-Security HTTP response header.
                                  override                   = optional(string) #  Whether CloudFront overrides the Strict-Transport-Security HTTP response header received from the origin with the one specified in this response headers policy.
                                  preload                    = optional(string) #  Whether CloudFront includes the preload directive in the Strict-Transport-Security HTTP response header
                                }
                              )
                            )
                            xss_protection = optional( # Determine whether CloudFront includes the X-XSS-Protection HTTP response header and the header’s value. 
                              object(
                                {
                                  mode_block = optional(string) # Whether CloudFront includes the mode=block directive in the X-XSS-Protection header.
                                  override   = optional(string) # Whether CloudFront overrides the X-XSS-Protection HTTP response header received from the origin with the one specified in this response headers policy.
                                  protection = optional(bool)   # A Boolean value that determines the value of the X-XSS-Protection HTTP response header. When this setting is true, the value of the X-XSS-Protection header is 1. When this setting is false, the value of the X-XSS-Protection header is 0.
                                  report_uri = optional(string) #  A reporting URI, which CloudFront uses as the value of the report directive in the X-XSS-Protection header. You cannot specify a report_uri when mode_block is true.
                                }
                              )
                            )
                          }
                        )
                      )
                      server_timing_headers_config = optional( # A configuration for enabling the Server-Timing header in HTTP responses sent from CloudFront.
                        object(
                          {
                            enabled       = optional(string) # A Whether CloudFront adds the Server-Timing header to HTTP responses that it sends in response to requests that match a cache behavior that's associated with this response headers policy.
                            sampling_rate = optional(string) #  A number 0–100 (inclusive) that specifies the percentage of responses that you want CloudFront to add the Server-Timing header to. Valid range: Minimum value of 0.0. Maximum value of 100.0.
                          }
                        )
                      )
                    }
                  )
                )
                smooth_streaming = optional(string) #  Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior.
                target_origin_id = string           # The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior.
                #trusted_key_groups             = optional(string)
                #trusted_signers                = optional(string)
                viewer_protocol_policy = optional(string)
              }
            )
          )
        )

        origin = optional( # One or more origins for this distribution (multiples allowed).
          set(
            object(
              {
                connection_attempts = optional(string) # The number of times that CloudFront attempts to connect to the origin. Must be between 1-3. Defaults to 3.
                connection_timeout  = optional(string) # The number of seconds that CloudFront waits when trying to establish a connection to the origin. Must be between 1-10. Defaults to 10.
                custom_origin_config = optional(       # The CloudFront custom origin configuration information. If an S3 origin is required, use origin_access_control_id or s3_origin_config instead.
                  object(
                    {
                      http_port                = optional(string)      # The HTTP port the custom origin listens on.
                      https_port               = optional(string)      # The HTTPS port the custom origin listens on.
                      origin_protocol_policy   = optional(string)      # The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer.
                      origin_ssl_protocols     = optional(set(string)) #  The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. A list of one or more of SSLv3, TLSv1, TLSv1.1, and TLSv1.2.
                      origin_keepalive_timeout = optional(string)      # The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase.
                      origin_read_timeout      = optional(string)      # The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase.
                    }
                  )
                )
                domain_name = string      # The DNS domain name of either the S3 bucket, or web site of your custom origin.
                custom_header = optional( # One or more sub-resources with name and value parameters that specify header data that will be sent to the origin (multiples allowed).
                  list(
                    object(
                      {
                        name  = optional(string)
                        value = optional(string)
                      }
                    )
                  )
                )
                origin_access_control_id = optional(string) # The unique identifier of a CloudFront origin access control for this origin.
                origin_id                = string           # A unique identifier for the origin
                origin_path              = optional(string) # An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin.
                origin_shield = optional(                   # The CloudFront Origin Shield configuration information. Using Origin Shield can help reduce the load on your origin. For more information, see Using Origin Shield in the Amazon CloudFront Developer Guide.
                  object(
                    {
                      enabled              = optional(string)
                      origin_shield_region = optional(string)
                    }
                  )
                )
                s3_origin_config = optional( # The CloudFront S3 origin configuration information. If a custom origin is required, use custom_origin_config instead.
                  object(
                    {
                      origin_access_identity = optional(string) # The CloudFront origin access identity to associate with the origin.
                    }
                  )
                )
              }
            )
          )
        )

        origin_group = optional( # One or more origin_group for this distribution (multiples allowed).
          set(
            object(
              {
                origin_id = optional(string)  # A unique identifier for the origin.
                failover_criteria = optional( # The failover criteria for when to failover to the secondary origin
                  object(
                    {
                      status_codes = optional(set(string)) #  A list of HTTP status codes for the origin group
                    }
                  )
                )
                member = optional( # Ordered member configuration blocks assigned to the origin group, where the first member is the primary origin. You must specify two members.
                  set(
                    object(
                      {
                        origin_id = optional(string) # The unique identifier of the member origin
                      }
                    )
                  )
                )
              }
            )
          )
        )

        price_class = optional(string)   # The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100
        restrictions = optional(object({ #  The restriction configuration for this distribution (maximum one).
          geo_restriction = optional(    # The restrictions sub-resource takes another single sub-resource named geo_restriction 
            object(
              {
                restriction_type = optional(string)      #  The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist.
                locations        = optional(set(string)) # The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist).
              }
            )
          )
          }
          )
        )
        retain_on_delete = optional(string) # Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. Default: false.
        viewer_certificate = optional(      # The SSL configuration for this distribution (maximum one).
          object(
            {
              acm_certificate_arn            = optional(string) # The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. Specify this, cloudfront_default_certificate, or iam_certificate_id. The ACM certificate must be in US-EAST-1.
              cloudfront_default_certificate = optional(string) # true if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution. Specify this, acm_certificate_arn, or iam_certificate_id.
              iam_certificate_id             = optional(string) # The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain. Specify this, acm_certificate_arn, or cloudfront_default_certificate.
              minimum_protocol_version       = optional(string) # The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. Can only be set if cloudfront_default_certificate = false. See all possible values in this table under "Security policy." Some examples include: TLSv1.2_2019 and TLSv1.2_2021. Default: TLSv1. NOTE: If you are using a custom certificate (specified with acm_certificate_arn or iam_certificate_id), and have specified sni-only in ssl_support_method, TLSv1 or later must be specified. If you have specified vip in ssl_support_method, only SSLv3 or TLSv1 can be specified. If you have specified cloudfront_default_certificate, TLSv1 must be specified.
              ssl_support_method             = optional(string) # Specifies how you want CloudFront to serve HTTPS requests. One of vip or sni-only. Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges.
            }
          )
        )
        wait_for_deployment = optional(string) #  If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. Default: true.
        web_acl_id          = optional(string) # A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution. To specify a web ACL created using the latest version of AWS WAF (WAFv2), use the ACL ARN, for example aws_wafv2_web_acl.example.arn. To specify a web ACL created using AWS WAF Classic, use the ACL ID, for example aws_waf_web_acl.example.id. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned.
      }
    )
  )
}