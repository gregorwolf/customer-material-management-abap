CLASS ygw_cl_cust_mat_proxy DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS
      get_client_proxy
        RETURNING VALUE(ro_client_proxy) TYPE REF TO /iwbep/if_cp_client_proxy
        RAISING   zcx_travels_cons_gw2
        .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ygw_cl_cust_mat_proxy IMPLEMENTATION.
  METHOD get_client_proxy.
    TRY.
        " 1. Get the destination of foreign system
        DATA: lv_url   TYPE string.
        lv_url = 'https://ba932c42trial-dev-customer-material-management-mock-srv.cfapps.eu10.hana.ondemand.com'.
        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( i_url = lv_url ).
        " 2. Create http client
        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

      CATCH cx_http_dest_provider_error INTO DATA(lx_http_dest_provider_error).
        "Handle exceptions
        RAISE EXCEPTION TYPE zcx_travels_cons_gw2
          EXPORTING
            textid   = zcx_travels_cons_gw2=>destination_provider_fail
            previous = lx_http_dest_provider_error.

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        RAISE EXCEPTION TYPE zcx_travels_cons_gw2
          EXPORTING
            textid   = zcx_travels_cons_gw2=>http_client_fail
            previous = lx_web_http_client_error.

    ENDTRY.

    TRY.

        "iv_service_definition_name = the service definition generated with Service Consumption Model (EDMX file)
        " iv_relative_service_root =

        ro_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'YGW_SC_CUST_MAT_CAP'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_CUSTOMER_MATERIAL_SRV/'
        ).

      CATCH cx_web_http_client_error INTO DATA(lx_http_client_error).
        RAISE EXCEPTION TYPE zcx_travels_cons_gw2
          EXPORTING
            textid   = zcx_travels_cons_gw2=>client_proxy_fail
            previous = lx_web_http_client_error.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_cp_remote).
        RAISE EXCEPTION TYPE zcx_travels_cons_gw2
          EXPORTING
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection
            textid   = zcx_travels_cons_gw2=>remote_access_fail
            previous = lx_cp_remote.

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        RAISE EXCEPTION TYPE zcx_travels_cons_gw2
          EXPORTING
            textid   = zcx_travels_cons_gw2=>gateway_fail
            previous = lx_gateway.

    ENDTRY.
  ENDMETHOD.

ENDCLASS.
