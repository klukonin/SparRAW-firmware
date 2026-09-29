/* wmi_handler_cfg_rx_chain @ 0x8f2ed0, 864 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   layer2_mgr.cpp
 *   Opening sniffer mode
 *       configuring CP (Control Phy) sniffing
 *       configuring DP (Data Phy) sniffing
 *       configuring AD (Auto Detection) sniffing
 *       configuring PRS TBL, PRS RGFs, PRP RGFs
 *       stopping PCP
 *       opening RX for channel (%d)
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: RADIO_MGR__set_primary_channel, __ld_r22_to_r13_ret, __st_r22_to_r13, dma_mgr__configure_ring, fw_log__emit0, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, get_g_800230, l2_offload__cfg_rx_decap, lmac_if__send_phy_ina_det_cfg, memcpy_fw
 * Глобалы (через gp): 0x800294, 0x8002c0
 */
	.section .text.wmi_handler_cfg_rx_chain,"ax",@progbits
	.global wmi_handler_cfg_rx_chain
wmi_handler_cfg_rx_chain:
	.global L_8f2ed0
L_8f2ed0:
	push_s blink
L_8f2ed2:
	bl L_8c02a4
L_8f2ed6:
	sub_s sp,sp,0x3c
L_8f2ed8:
	mov_s r13,r0
L_8f2eda:
	bl.d L_8c2b68
L_8f2ede:
	mov_s r18,r1
L_8f2ee0:
	mov.f r16,r0
L_8f2ee4:
	beq_s L_8f2efe
	.global L_8f2ee6
L_8f2ee6:
	ldw_s r0,[r13,0x26]
L_8f2ee8:
	ldw_s r1,[r13,0x24]
L_8f2eea:
	asl_s r0,r0,0x10
L_8f2eec:
	or_s r1,r1,r0
L_8f2eee:
	mov_s r14,0x2
L_8f2ef0:
	mov r19,0x1
L_8f2ef4:
	breq r1,0x1,L_8f2f16
L_8f2ef8:
	add r14,r13,0x20
L_8f2efc:
	b_s L_8f3050
	.global L_8f2efe
L_8f2efe:
	mov_s r0,blink
L_8f2f00:
	mov_s r2,0x100c474
L_8f2f06:
	mov_s r1,0x1342
L_8f2f0c:
	bl.d L_8c82c0
L_8f2f10:
	mov r3,0x6dc
L_8f2f14:
	b_s L_8f2ee6
	.global L_8f2f16
L_8f2f16:
	add_s r15,sp,0x4
L_8f2f18:
	mov_s r1,0x800af8
L_8f2f1e:
	mov_s r0,r15
L_8f2f20:
	bl.d L_8c0460
L_8f2f24:
	mov_s r2,0x24
L_8f2f26:
	mov_s r2,0x100c818
L_8f2f2c:
	mov_s r0,0xb
L_8f2f2e:
	bl.d L_8edfb0
L_8f2f32:
	mov_s r1,r14
L_8f2f34:
	ldw_s r0,[r13,0x2e]
L_8f2f36:
	ldw_s r1,[r13,0x2c]
L_8f2f38:
	asl_s r0,r0,0x10
L_8f2f3a:
	or_s r1,r1,r0
L_8f2f3c:
	stb_s r14,[r13,0x11]
L_8f2f3e:
	brne_s r1,0,L_8f2f58
L_8f2f40:
	mov_s r2,0x100c830
L_8f2f46:
	mov_s r0,0xb
L_8f2f48:
	bl.d L_8edfb0
L_8f2f4c:
	mov_s r1,r14
L_8f2f4e:
	ld_s r0,[sp,0x24]
L_8f2f50:
	bclr_s r0,r0,0x1
	.global L_8f2f52
L_8f2f52:
	bclr_s r0,r0,0x0
L_8f2f54:
	st_s r0,[sp,0x24]
L_8f2f56:
	b_s L_8f2fa4
	.global L_8f2f58
L_8f2f58:
	brne r1,0x1,L_8f2f76
L_8f2f5c:
	mov_s r2,0x100c85c
L_8f2f62:
	mov_s r0,0xb
L_8f2f64:
	bl.d L_8edfb0
L_8f2f68:
	mov_s r1,r14
L_8f2f6a:
	ld_s r0,[sp,0x24]
L_8f2f6c:
	bic r0,r0,0x3
L_8f2f70:
	st_s r0,[sp,0x24]
L_8f2f72:
	stb_s r14,[sp,0x8]
L_8f2f74:
	b_s L_8f2fa4
	.global L_8f2f76
L_8f2f76:
	brne r1,0x2,L_8f2f8e
L_8f2f7a:
	mov_s r2,0x100c884
L_8f2f80:
	mov_s r0,0xb
L_8f2f82:
	bl.d L_8edfb0
L_8f2f86:
	mov_s r1,r14
L_8f2f88:
	ld_s r0,[sp,0x24]
L_8f2f8a:
	bset_s r0,r0,0x1
L_8f2f8c:
	b_s L_8f2f52
	.global L_8f2f8e
L_8f2f8e:
	mov_s r0,blink
L_8f2f90:
	mov_s r2,0x100c474
L_8f2f96:
	mov_s r1,0x11e3
L_8f2f9c:
	bl.d L_8c82c0
L_8f2fa0:
	mov r3,0x6fe
	.global L_8f2fa4
L_8f2fa4:
	bl.d L_8d8824
L_8f2fa8:
	mov_s r0,r15
L_8f2faa:
	mov_s r2,0x100c8b4
L_8f2fb0:
	mov_s r0,0xb
L_8f2fb2:
	bl.d L_8edfb0
L_8f2fb6:
	mov_s r1,0x2
L_8f2fb8:
	mov_s r1,0x886200
L_8f2fbe:
	ld_s r0,[r1,0x58]
L_8f2fc0:
	mov_s r14,0x0
L_8f2fc2:
	bic r0,r0,0x1f
L_8f2fc6:
	bset_s r0,r0,0x1
L_8f2fc8:
	st_s r0,[r1,0x58]
L_8f2fca:
	ld_s r0,[r1]
L_8f2fcc:
	bset_s r0,r0,0x8
L_8f2fce:
	st_s r0,[r1]
L_8f2fd0:
	mov_s r1,0x886800
L_8f2fd6:
	ld_s r0,[r1,0x38]
L_8f2fd8:
	bset_s r0,r0,0x0
L_8f2fda:
	st_s r0,[r1,0x38]
L_8f2fdc:
	mov_s r0,0x886d80
L_8f2fe2:
	st 0x31000400,[r0, 0x48]
L_8f2fea:
	bl.d L_8d73c4
L_8f2fee:
	mov_s r0,r14
L_8f2ff0:
	breq_s r0,0,L_8f3020
L_8f2ff2:
	mov_s r2,0x100c8e0
L_8f2ff8:
	mov_s r0,0xb
L_8f2ffa:
	bl.d L_8edfb0
L_8f2ffe:
	mov_s r1,0x2
L_8f3000:
	stw r14,[sp, 0x28]
L_8f3004:
	add_s r0,sp,0x28
L_8f3006:
	bl.d L_8e7924
L_8f300a:
	mov_s r1,r14
L_8f300c:
	mov_s r0,0xc3500
L_8f3012:
	mov lp_count,r0
L_8f3016:
	nop_s
L_8f3018:
	lp L_8f3020
L_8f301c:
	nop_s
L_8f301e:
	nop_s
	.global L_8f3020
L_8f3020:
	mov_s r2,0x100c8f4
L_8f3026:
	add r14,r13,0x20
L_8f302a:
	mov_s r0,0xb
L_8f302c:
	mov_s r1,0x2
L_8f302e:
	bl.d L_8edfcc
L_8f3032:
	ldb_s r3,[r14,0x10]
L_8f3034:
	mov_s r2,0x805bd4
L_8f303a:
	ld_s r1,[r2,0x8]
L_8f303c:
	extb r5,r18
L_8f3040:
	ldb_s r0,[r14,0x10]
L_8f3042:
	ld_s r2,[r2,0xc]
L_8f3044:
	ld.as r3,[gp,0x54]
L_8f3048:
	bl.d L_8e1ed8
L_8f304c:
	mov r4,0x1
	.global L_8f3050
L_8f3050:
	bl L_8cabdc
L_8f3054:
	mov_s r21,r0
L_8f3056:
	ldw_s r0,[r13,0xe]
L_8f3058:
	mov_s r15,0x1f28
L_8f305e:
	min r17,r0,r15
L_8f3062:
	mov_s r0,0x80345c
L_8f3068:
	ld_s r0,[r0,0xc]
L_8f306a:
	breq_s r0,0,L_8f307e
L_8f306c:
	mov_s r2,0x100c914
L_8f3072:
	mov_s r0,0xb
L_8f3074:
	mov_s r1,0x2
L_8f3076:
	bl.d L_8edfcc
L_8f307a:
	mov_s r3,r15
L_8f307c:
	mov_s r17,r15
	.global L_8f307e
L_8f307e:
	ldb_s r0,[r14,0x2]
L_8f3080:
	brne r0,0x1,L_8f308c
L_8f3084:
	st.as r19,[gp,0x49]
L_8f3088:
	mov_s r15,0x40
L_8f308a:
	b_s L_8f309a
	.global L_8f308c
L_8f308c:
	asl r15,r21
L_8f3090:
	cmp_s r15,0x40
L_8f3092:
	bhi_s L_8f30c0
	.global L_8f3094
L_8f3094:
	mov_s r0,0x0
L_8f3096:
	st.as r0,[gp,0x49]
	.global L_8f309a
L_8f309a:
	mov_s r2,0x100c938
L_8f30a0:
	ldb r5,[r14, 0x2]
L_8f30a4:
	mov_s r0,0xb
L_8f30a6:
	mov_s r1,0x2
L_8f30a8:
	mov_s r3,r17
L_8f30aa:
	bl.d L_8ee034
L_8f30ae:
	mov r4,r21
L_8f30b2:
	ldw r20,[r13, 0x34]
L_8f30b6:
	brge r20,0x3,L_8f30d8
	.global L_8f30ba
L_8f30ba:
	mov r20,0x0
L_8f30be:
	b_s L_8f3110
	.global L_8f30c0
L_8f30c0:
	mov_s r0,blink
L_8f30c2:
	mov_s r2,0x100c474
L_8f30c8:
	mov_s r1,0x11e4
L_8f30ce:
	bl.d L_8c82c0
L_8f30d2:
	mov r3,0x73e
L_8f30d6:
	b_s L_8f3094
	.global L_8f30d8
L_8f30d8:
	brlt r20,0x1,L_8f30e8
L_8f30dc:
	rsub r0,r20,0x0
L_8f30e0:
	and r0,r0,r20
L_8f30e4:
	breq r0,r20,L_8f3110
	.global L_8f30e8
L_8f30e8:
	mov_s r2,0x100c97c
L_8f30ee:
	mov_s r0,0xb
L_8f30f0:
	mov_s r1,0x2
L_8f30f2:
	bl.d L_8edfcc
L_8f30f6:
	mov_s r3,r20
L_8f30f8:
	mov_s r0,blink
L_8f30fa:
	mov_s r2,0x100c474
L_8f3100:
	mov_s r1,0x1343
L_8f3106:
	bl.d L_8c82c0
L_8f310a:
	mov r3,0x753
L_8f310e:
	b_s L_8f30ba
	.global L_8f3110
L_8f3110:
	extw r22,r15
L_8f3114:
	bl.d L_8e212c
L_8f3118:
	mov_s r0,r22
L_8f311a:
	bl L_8f1844
L_8f311e:
	bl.d L_8ca828
L_8f3122:
	mov_s r0,0x2
L_8f3124:
	mov_s r15,r0
L_8f3126:
	ldw_s r0,[r13,0x26]
L_8f3128:
	ldw_s r1,[r13,0x24]
L_8f312a:
	asl_s r0,r0,0x10
L_8f312c:
	or_s r1,r1,r0
L_8f312e:
	brne r1,0x1,L_8f3158
L_8f3132:
	st r19,[sp]
L_8f3136:
	mov_s r0,r15
L_8f3138:
	mov_s r1,0x2
L_8f313a:
	mov_s r2,0x3
L_8f313c:
	mov_s r3,r17
L_8f313e:
	mov r4,0x1000
L_8f3146:
	mov r5,r4
L_8f314a:
	mov r6,0x8
L_8f314e:
	bl.d L_8d6390
L_8f3152:
	mov r7,r22
L_8f3156:
	b_s L_8f3186
	.global L_8f3158
L_8f3158:
	mov_s r0,0x0
L_8f315a:
	st_s r0,[sp,0x0]
L_8f315c:
	mov_s r0,r15
L_8f315e:
	mov_s r1,0x2
L_8f3160:
	mov_s r2,0x3
L_8f3162:
	mov_s r3,r17
L_8f3164:
	mov r4,0x1000
L_8f316c:
	mov r5,r4
L_8f3170:
	mov r6,0x8
L_8f3174:
	bl.d L_8d6390
L_8f3178:
	mov r7,r22
L_8f317c:
	ldb_s r0,[r14,0x2]
L_8f317e:
	brne r0,0x1,L_8f3186
L_8f3182:
	st r19,[r15, 0xc]
	.global L_8f3186
L_8f3186:
	mov_s r0,r15
L_8f3188:
	mov_s r1,0x2
L_8f318a:
	bl.d L_8dd124
L_8f318e:
	mov_s r2,0x0
L_8f3190:
	extb r3,r21
L_8f3194:
	mov_s r0,r15
L_8f3196:
	mov_s r1,0x0
L_8f3198:
	mov_s r2,0x0
L_8f319a:
	bl.d L_8c3b48
L_8f319e:
	mov r4,r22
L_8f31a2:
	mov_s r2,0x100c9bc
L_8f31a8:
	mov_s r0,0xb
L_8f31aa:
	mov_s r1,0x2
L_8f31ac:
	bl.d L_8edfcc
L_8f31b0:
	ldw_s r3,[r13,0x34]
L_8f31b2:
	ldb_s r0,[r13,0x5]
L_8f31b4:
	ldb_s r1,[r13,0x4]
L_8f31b6:
	asl_s r0,r0,0x8
L_8f31b8:
	or_s r1,r1,r0
L_8f31ba:
	ldb_s r0,[r13,0x6]
L_8f31bc:
	ldb_s r2,[r13,0x8]
L_8f31be:
	asl_s r0,r0,0x10
L_8f31c0:
	or_s r1,r1,r0
L_8f31c2:
	ldb_s r0,[r13,0x7]
L_8f31c4:
	ldw r4,[r13, 0x20]
L_8f31c8:
	asl_s r0,r0,0x18
L_8f31ca:
	or_s r1,r1,r0
L_8f31cc:
	ldb_s r0,[r13,0x9]
L_8f31ce:
	ldw r5,[r13, 0x1a]
L_8f31d2:
	asl_s r0,r0,0x8
L_8f31d4:
	or_s r2,r2,r0
L_8f31d6:
	ldb_s r0,[r13,0xa]
L_8f31d8:
	ldw_s r3,[r13,0xc]
L_8f31da:
	asl_s r0,r0,0x10
L_8f31dc:
	or_s r2,r2,r0
L_8f31de:
	ldb_s r0,[r13,0xb]
L_8f31e0:
	mov r6,0x0
L_8f31e4:
	asl_s r0,r0,0x18
L_8f31e6:
	or_s r2,r2,r0
L_8f31e8:
	mov_s r0,0x2
L_8f31ea:
	bl.d L_8c611c
L_8f31ee:
	mov r7,r20
L_8f31f2:
	bl.d L_8ea660
L_8f31f6:
	mov_s r0,r13
L_8f31f8:
	bl L_8cda88
L_8f31fc:
	mov_s r2,0x100c9e0
L_8f3202:
	st r0,[r16]
L_8f3206:
	st r19,[r16, 0x4]
L_8f320a:
	mov_s r0,0xb
L_8f320c:
	mov_s r1,0x2
L_8f320e:
	bl.d L_8edfcc
L_8f3212:
	mov_s r3,r18
L_8f3214:
	mov_s r0,r16
L_8f3216:
	mov_s r1,0xc1
L_8f3218:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8f321a:
	mov_s r2,0x8
L_8f321c:
	mov_s r3,r18
L_8f321e:
	mov r4,0x0
L_8f3222:
	bl.d L_8e0874
L_8f3226:
	mov r5,0x0
L_8f322a:
	b.d L_8c02f4
L_8f322e:
	add_s sp,sp,0x3c
