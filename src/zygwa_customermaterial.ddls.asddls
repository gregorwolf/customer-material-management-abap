/********** GENERATED on 09/10/2020 at 12:45:39 by CB0000000282**************/
 @OData.entitySet.name: 'A_CustomerMaterial' 
 @OData.entityType.name: 'A_CustomerMaterialType' 
 define root abstract entity ZYGWA_CUSTOMERMATERIAL { 
 key SalesOrganization : abap.char( 4 ) ; 
 key DistributionChannel : abap.char( 2 ) ; 
 key Customer : abap.char( 10 ) ; 
 key Material : abap.char( 40 ) ; 
 @Odata.property.valueControl: 'MaterialByCustomer_vc' 
 MaterialByCustomer : abap.char( 35 ) ; 
 MaterialByCustomer_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'MaterialDescriptionByCustom_vc' 
 MaterialDescriptionByCustomer : abap.char( 40 ) ; 
 MaterialDescriptionByCustom_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Plant_vc' 
 Plant : abap.char( 4 ) ; 
 Plant_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'DeliveryPriority_vc' 
 DeliveryPriority : abap.numc( 2 ) ; 
 DeliveryPriority_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'MinDeliveryQtyInBaseUnit_vc' 
 @Semantics.quantity.unitOfMeasure: 'BaseUnit' 
 MinDeliveryQtyInBaseUnit : abap.dec( 13, 3 ) ; 
 MinDeliveryQtyInBaseUnit_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BaseUnit_vc' 
 @Semantics.unitOfMeasure: true 
 BaseUnit : abap.unit( 3 ) ; 
 BaseUnit_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'PartialDeliveryIsAllowed_vc' 
 PartialDeliveryIsAllowed : abap.char( 1 ) ; 
 PartialDeliveryIsAllowed_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'MaxNmbrOfPartialDelivery_vc' 
 MaxNmbrOfPartialDelivery : abap.dec( 1, 0 ) ; 
 MaxNmbrOfPartialDelivery_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'UnderdelivTolrtdLmtRatioInP_vc' 
 UnderdelivTolrtdLmtRatioInPct : abap.dec( 3, 1 ) ; 
 UnderdelivTolrtdLmtRatioInP_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'OverdelivTolrtdLmtRatioInPc_vc' 
 OverdelivTolrtdLmtRatioInPct : abap.dec( 3, 1 ) ; 
 OverdelivTolrtdLmtRatioInPc_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'UnlimitedOverdeliveryIsAllo_vc' 
 UnlimitedOverdeliveryIsAllowed : abap_boolean ; 
 UnlimitedOverdeliveryIsAllo_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CustomerMaterialItemUsage_vc' 
 CustomerMaterialItemUsage : abap.char( 4 ) ; 
 CustomerMaterialItemUsage_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SalesUnit_vc' 
 SalesUnit : abap.char( 3 ) ; 
 SalesUnit_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SalesQtyToBaseQtyDnmntr_vc' 
 SalesQtyToBaseQtyDnmntr : abap.dec( 5, 0 ) ; 
 SalesQtyToBaseQtyDnmntr_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SalesQtyToBaseQtyNmrtr_vc' 
 SalesQtyToBaseQtyNmrtr : abap.dec( 5, 0 ) ; 
 SalesQtyToBaseQtyNmrtr_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'ETag_vc' 
 ETag : abap.char( 10 ) ; 
 ETag_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 ETAG__ETAG : abap.string( 0 ) ; 
 
 } 
