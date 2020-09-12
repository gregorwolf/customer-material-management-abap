CLASS ygw_cl_cust_mat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ygw_cl_cust_mat IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    DATA: lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_customer   TYPE RANGE OF zygwa_customermaterial-customer.

    """Instantiate Client Proxy
    DATA(lo_client_proxy) = ygw_cl_cust_mat_proxy=>get_client_proxy( ).

    TRY.
        """Create Read Request
        DATA(lo_read_request) = lo_client_proxy->create_resource_for_entity_set( 'A_CUSTOMERMATERIAL' )->create_request_for_read( ).

        """Request Count
        IF io_request->is_total_numb_of_rec_requested( ).
          lo_read_request->request_count( ).
        ENDIF.

        """Request Paging
        DATA(ls_paging) = io_request->get_paging( ).
        IF ls_paging->get_offset( ) >= 0.
          lo_read_request->set_skip( ls_paging->get_offset( ) ).
        ENDIF.

        " Create the filter
        lt_range_customer = VALUE #( ( sign = 'I' option = 'EQ' low = '1000021' ) ).
        lo_filter_factory = lo_read_request->create_filter_factory( ).
        lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'CUSTOMER'
                                                                it_range             = lt_range_customer ).
        lo_read_request->set_filter( lo_filter_node_1 ).


        IF ls_paging->get_page_size( ) <> if_rap_query_paging=>page_size_unlimited.
          lo_read_request->set_top( ls_paging->get_page_size( ) ).

          """Execute the Request
          DATA(lo_response) = lo_read_request->execute( ).
        ENDIF.

        "Provide result data
        IF io_request->is_data_requested( ).

          DATA:
            "abstract entity; receives data from remote servce
            it_cust_mat    TYPE STANDARD TABLE OF zygwa_customermaterial,
            "custom entity; fills output param of SELECT
            it_cust_mat_ce TYPE STANDARD TABLE OF ygw_ce_cust_mat.

          "Get data from response object
          lo_response->get_business_data( IMPORTING et_business_data = it_cust_mat ).
          " Check if it_cust_mat returns entries; map elements
          IF it_cust_mat IS NOT INITIAL.
            it_cust_mat_ce = CORRESPONDING #( it_cust_mat ).
          ENDIF.
          "Set return data
          io_response->set_data( it_cust_mat_ce ).
          io_response->set_total_number_of_records( lo_response->get_count(  ) ).
        ENDIF.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        RAISE EXCEPTION TYPE ycx_cust_mat
          EXPORTING
            textid   = ycx_cust_mat=>query_fail
            previous = lx_gateway.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
