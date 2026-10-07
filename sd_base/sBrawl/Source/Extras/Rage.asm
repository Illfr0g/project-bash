#################
Rage (SSB4) [Eon]
#################
HOOK @ $80769fc8
{

    fadds f27, f5, f0 #original command, adds base knockback

    lwz r3, 0x28(r24)
    lwz r3, 0xD8(r3)
    lwz r3, 0x38(r3)
    li r4, 0
    lwz r12, 0x8(r3)
    lwz r12, 0x50(r12)
    mtctr r12 
    bctrl #getDamage #f1 = damage percent 
    bl data 
    mflr r3 #pointer to data
    lfs f0, 0x4(r3)
    fcmpo cr0, f1, f0
    blt end
    lfs f2, 0x8(r3)
    fadds f0, f2, f0
    fcmpo cr0, f1, f0
    blt scale 
    fmr f1, f0
scale:   
    lfs f0, 0x4(r3)
    fsubs f1, f1, f0
    lfs f0, 0x8(r3)
    fdivs f1, f1, f0
    lfs f0, 0xC(r3)
    fmuls f1, f1, f0
    lfs f0, 0x0(r3)
    fadds f1, f1, f0
    fmuls f27, f1, f27
    b end

data:
       blrl
    word 0x3F800000 #1.0 #min multiplier and base value
    word 0x420C0000 #35.0 #min percent of rage
    word 0x42E60000 #115.0 #range of damage taken (e.g. 115 + 35 = 150% is max damage)
    word 0x3E19999A  #0.1 #max strength of rage increase


#if p > 115+35:
#  knockback *= 1.15
#elif p > 35
#  knockback *= 1 + 0.15*(percent-35)/115
end:
}