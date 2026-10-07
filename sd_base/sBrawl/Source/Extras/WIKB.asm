############################################
WDSK FFFF = Weight Independant KB [MarioDox]
############################################
HOOK @ $80769ecc #notifyEventCollsionHit2nd/[soDamageModuleImpl]
{
    lwz r0, 0x1C(r27) #original op, get wdsk
    cmplwi r0, 0xFFFF
    bne+ %END%
    lis r0, 0x3FF0        #\ Write 1 in float
    stw r0, 0x1C(r27)    #| Store it somewhere safe
    lfs f1, 0x1C(r27)    #/ Use it in weight calculations
    li r0, 0
    stw r0, 0x1C(r27)    # Reset to 0 to avoid problems
}