@EndUserText.label: 'Customer Material - Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:YGW_CL_CUST_MAT'
define custom entity YGW_CE_CUST_MAT
{
  key SalesOrganization              : abap.char( 4 );
  key DistributionChannel            : abap.char( 2 );
      @UI.lineItem   : [ { position: 10 } ]
  key Customer                       : abap.char( 10 );
      @UI.lineItem   : [ { position: 20 } ]
  key Material                       : abap.char( 40 );
      @UI.lineItem   : [ { position: 30 } ]
      MaterialByCustomer             : abap.char( 35 );
      @UI.lineItem   : [ { position: 40 } ]
      MaterialDescriptionByCustomer  : abap.char( 40 );
}
