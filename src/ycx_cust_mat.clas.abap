CLASS ycx_cust_mat DEFINITION
  PUBLIC
  INHERITING FROM cx_rap_query_provider
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF destination_provider_fail,
        msgid TYPE symsgid VALUE 'ZCM_TRAVELS_GW2',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF destination_provider_fail.
    CONSTANTS:
      BEGIN OF http_client_fail,
        msgid TYPE symsgid VALUE 'ZCM_TRAVELS_GW2',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF http_client_fail.
    CONSTANTS:
      BEGIN OF client_proxy_fail,
        msgid TYPE symsgid VALUE 'ZCM_TRAVELS_GW2',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF client_proxy_fail.
    CONSTANTS:
      BEGIN OF remote_access_fail,
        msgid TYPE symsgid VALUE 'ZCM_TRAVELS_GW2',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF remote_access_fail.
    CONSTANTS:
      BEGIN OF gateway_fail,
        msgid TYPE symsgid VALUE 'ZCM_TRAVELS_GW2',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF gateway_fail.
    CONSTANTS:
      BEGIN OF query_fail,
        msgid TYPE symsgid VALUE 'ZCM_TRAVELS_GW2',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF query_fail.
    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ycx_cust_mat IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
