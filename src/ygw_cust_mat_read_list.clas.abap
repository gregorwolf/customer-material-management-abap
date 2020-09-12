CLASS ygw_cust_mat_read_list DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ygw_cust_mat_read_list IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lt_business_data   TYPE TABLE OF zygwa_customermaterial,
          lo_request         TYPE REF TO /iwbep/if_cp_request_read_list,
          lt_select_property TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path,
          lo_response        TYPE REF TO /iwbep/if_cp_response_read_lst.

    DATA: lv_url   TYPE string,
          lv_lines TYPE i,
          lv_out   TYPE string.

    DATA: lv_PROGRAM_NAME TYPE syrepid,
          lv_INCLUDE_NAME TYPE syrepid,
          lv_SOURCE_LINE  TYPE i.


    DATA: lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
          lt_range_customer   TYPE RANGE OF zygwa_customermaterial-customer.

    out->write( 'Start' ).
    out->write( |Running as { sy-uname }| ).
    TRY.
        out->write( 'Get client proxy' ).
        DATA(lo_client_proxy) = zcl_cust_mat_proxy=>get_client_proxy( ).

        " Navigate to the resource and create a request for the read operation
        out->write( 'Create request' ).
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_CUSTOMERMATERIAL' )->create_request_for_read( ).

        " Create the filter
        lt_range_customer = VALUE #( ( sign = 'I' option = 'EQ' low = '1000021' ) ).
        lo_filter_factory = lo_request->create_filter_factory( ).
        lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'CUSTOMER'
                                                                it_range             = lt_range_customer ).
        " lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
        lo_request->set_filter( lo_filter_node_1 ).
        " Select only specific fields
        APPEND INITIAL LINE TO lt_select_property ASSIGNING FIELD-SYMBOL(<fs_select_property>).
        <fs_select_property> = 'MATERIAL'.
        APPEND INITIAL LINE TO lt_select_property ASSIGNING <fs_select_property>.
        <fs_select_property> = 'MATERIALBYCUSTOMER'.

        lo_request->set_select_properties( it_select_property = lt_select_property ).
        lo_request->set_top( 4 )->set_skip( 0 ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).
        out->write( 'Get Business Data' ).
        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).
        lv_lines = lines( lt_business_data ).
        out->write( |Number of hits: { lv_lines }| ).
        LOOP AT lt_business_data ASSIGNING FIELD-SYMBOL(<fs_data>).
          lv_out = |{ <fs_data>-material } - { <fs_data>-materialbycustomer }|.
          out->write( lv_out ).
        ENDLOOP.
*      CATCH BEFORE UNWIND cx_root INTO DATA(lx_root).
*        out->write( 'Catch before unwind' ).
*        out->write( lx_root->get_text( ) ).
      CATCH cx_web_message_error INTO DATA(lx_web_message).
        out->write( 'Web Message Exception' ).
        out->write( lx_web_message->get_text( ) ).
      CATCH cx_http_dest_provider_error INTO DATA(lx_dest).
        out->write( 'destination creation exception' ).
      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        out->write( 'remote exception' ).
        out->write( lx_remote->get_text( ) ).
        " It contains details about the problems of your http(s) connection
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        out->write( 'gateway exception' ).
        out->write( lx_gateway->get_text( ) ).
        out->write( 'Source position:' ).
        lx_gateway->get_source_position(
          IMPORTING
            program_name = lv_program_name
            include_name = lv_include_name
            source_line  = lv_source_line
        ).
        out->write( |Program: { lv_program_name }, Include: { lv_include_name }, Source Line: { lv_source_line }| ).
        out->write( 'Long text:' ).
        out->write( lx_gateway->get_longtext( ) ).

    ENDTRY.
  ENDMETHOD.
ENDCLASS.
