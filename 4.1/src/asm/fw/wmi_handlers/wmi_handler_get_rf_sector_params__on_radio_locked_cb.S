/* wmi_handler_get_rf_sector_params__on_radio_locked_cb @ 0x8caff0, 292 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handlers.cpp
 *   wmi_handler_get_rf_sector_params::on_radio_locked_cb(): Reading RF Sector: rfc_idx=%d, sector_idx=%d, sector_type=%d,
 *   [NNL] psh_hi=0x%X, psh_lo=0x%X, etype0=0x%X,
 *   [NNL] etype1=0x%X, etype2=0x%X, dtype_swch_off=0x%X,
 * Зовут его: rf_sector__read_on_radio_locked
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, bitmap__alloc_bit, bitmap__any_free, bitmap__init, fw_log__emit3, fw_sysassert_fatal, get_g_800227, mac_read_tsf64, memcpy_fw
 */
	.section .text.wmi_handler_get_rf_sector_params__on_radio_locked_cb,"ax",@progbits
	.global wmi_handler_get_rf_sector_params__on_radio_locked_cb
wmi_handler_get_rf_sector_params__on_radio_locked_cb:
	.global L_8caff0
L_8caff0:
	push_s blink
L_8caff2:
	bl L_8c02bc
L_8caff6:
	sub_s sp,sp,0x20
L_8caff8:
	mov_s r14,r0
L_8caffa:
	bl.d L_8c2c38
L_8caffe:
	ld_s r0,[r0,0x4]
L_8cb000:
	mov_s r15,r0
L_8cb002:
	bl.d L_8c1a78
L_8cb006:
	mov_s r1,0xd0
L_8cb008:
	mov_s r0,0x803e84
L_8cb00e:
	bl L_8ca80c
L_8cb012:
	ldb_s r1,[r14,0x3]
L_8cb014:
	mov_s r2,r0
L_8cb016:
	add_s r0,sp,0x4
L_8cb018:
	mov_s r16,r0
L_8cb01a:
	bl.d L_8e1140
L_8cb01e:
	and_s r1,r1,r2
L_8cb020:
	b_s L_8cb0d0
	.global L_8cb022
L_8cb022:
	bl.d L_8db194
L_8cb026:
	mov_s r0,r16
L_8cb028:
	brlo.d r0,0x8,L_8cb044
L_8cb02c:
	mov_s r13,r0
L_8cb02e:
	mov_s r0,blink
L_8cb030:
	mov_s r2,0x100710c
L_8cb036:
	mov_s r1,0x146e
L_8cb03c:
	bl.d L_8c82c0
L_8cb040:
	mov r3,0x138
	.global L_8cb044
L_8cb044:
	add_s r0,sp,0x8
L_8cb046:
	mov_s r1,0x801cc4
L_8cb04c:
	bl.d L_8c0460
L_8cb050:
	mov_s r2,0x18
L_8cb052:
	ldb_s r1,[r14,0x2]
L_8cb054:
	extb_s r0,r13
L_8cb056:
	cmp_s r1,0x1
L_8cb058:
	mov_s r2,0x1
L_8cb05a:
	sub_s.ne r2,r2,r2
L_8cb05c:
	add_s r3,sp,0x8
L_8cb05e:
	add r4,sp,0xc
L_8cb062:
	add r5,sp,0x10
L_8cb066:
	add r6,sp,0x14
L_8cb06a:
	add r7,sp,0x18
L_8cb06e:
	add_s r1,sp,0x1c
L_8cb070:
	st_s r1,[sp,0x0]
L_8cb072:
	bl.d L_8d0580
L_8cb076:
	ldw_s r1,[r14]
L_8cb078:
	asl_s r0,r13,0x3
L_8cb07a:
	add1_s r0,r0,r0
L_8cb07c:
	add_s r0,r0,r15
L_8cb07e:
	add_s r0,r0,0x10
L_8cb080:
	add_s r1,sp,0x8
L_8cb082:
	bl.d L_8c0460
L_8cb086:
	mov_s r2,0x18
L_8cb088:
	ldw r4,[r14]
L_8cb08c:
	mov_s r2,0x1007544
L_8cb092:
	ldb r5,[r14, 0x2]
L_8cb096:
	mov_s r0,0x0
L_8cb098:
	mov_s r1,0x2
L_8cb09a:
	bl.d L_8ee034
L_8cb09e:
	mov_s r3,r13
L_8cb0a0:
	ld r4,[sp, 0xc]
L_8cb0a4:
	mov_s r2,0x10075bc
L_8cb0aa:
	ld r5,[sp, 0x10]
L_8cb0ae:
	mov_s r0,0x0
L_8cb0b0:
	mov_s r1,0x2
L_8cb0b2:
	bl.d L_8ee034
L_8cb0b6:
	ld_s r3,[sp,0x8]
L_8cb0b8:
	mov_s r2,0x10075ec
L_8cb0be:
	ld r4,[sp, 0x18]
L_8cb0c2:
	mov_s r0,0x0
L_8cb0c4:
	ld r5,[sp, 0x1c]
L_8cb0c8:
	mov_s r1,0x2
L_8cb0ca:
	bl.d L_8ee034
L_8cb0ce:
	ld_s r3,[sp,0x14]
	.global L_8cb0d0
L_8cb0d0:
	bl.d L_8cb680
L_8cb0d4:
	mov_s r0,r16
L_8cb0d6:
	brne r0,0x0,L_8cb022
L_8cb0da:
	add r1,r15,0x8
L_8cb0de:
	mov r16,0x0
L_8cb0e2:
	mov_s r0,r16
L_8cb0e4:
	bl.d L_8e4840
L_8cb0e8:
	mov_s r2,r16
L_8cb0ea:
	stb r16,[r15]
L_8cb0ee:
	ld_s r0,[r14,0x4]
L_8cb0f0:
	mov_s r1,r15
L_8cb0f2:
	mov_s r2,r16
L_8cb0f4:
	mov_s r3,0xcd
L_8cb0f6:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8cb0f8:
	mov r4,0xd0
L_8cb0fc:
	mov r5,r16
L_8cb100:
	mov r6,r16
L_8cb104:
	bl.d L_8e0460
L_8cb108:
	mov r7,r16
L_8cb10c:
	b.d L_8c0324
L_8cb110:
	add_s sp,sp,0x20
L_8cb112:
	nop_s
