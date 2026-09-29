/* wmi_handler_set_rf_sector_params__set_rf_sector_params @ 0x8cb114, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handlers.cpp
 *   wmi_handler_set_rf_sector_params::set_rf_sector_params(): Writing RF Sector: rfc_idx=%d, sector_idx=%d, sector_type=%d,
 *   [NNL] psh_hi=0x%X, psh_lo=0x%X, etype0=0x%X,
 *   [NNL] etype1=0x%X, etype2=0x%X, dtype_swch_off=0x%X,
 * Зовут его: rf_sector__apply_on_radio_locked
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, bitmap__alloc_bit, bitmap__any_free, bitmap__init, fw_log__emit3, fw_sysassert_fatal, get_g_800227, memset0_words, rf_sector_params_write
 */
	.section .text.wmi_handler_set_rf_sector_params__set_rf_sector_params,"ax",@progbits
	.global wmi_handler_set_rf_sector_params__set_rf_sector_params
wmi_handler_set_rf_sector_params__set_rf_sector_params:
	.global L_8cb114
L_8cb114:
	push_s blink
L_8cb116:
	bl L_8c02b0
L_8cb11a:
	sub_s sp,sp,0xc
L_8cb11c:
	mov_s r13,r0
L_8cb11e:
	bl.d L_8c2c38
L_8cb122:
	ld r0,[r0, 0xc4]
L_8cb126:
	mov_s r17,r0
L_8cb128:
	bl.d L_8c1a78
L_8cb12c:
	mov_s r1,0x1
L_8cb12e:
	mov_s r0,0x803e84
L_8cb134:
	bl L_8ca80c
L_8cb138:
	ldb_s r1,[r13,0x3]
L_8cb13a:
	mov_s r2,r0
L_8cb13c:
	add_s r0,sp,0x8
L_8cb13e:
	mov_s r16,r0
L_8cb140:
	bl.d L_8e1140
L_8cb144:
	and_s r1,r1,r2
L_8cb146:
	b_s L_8cb1ee
	.global L_8cb148
L_8cb148:
	bl.d L_8db194
L_8cb14c:
	mov_s r0,r16
L_8cb14e:
	brlo.d r0,0x8,L_8cb16a
L_8cb152:
	mov_s r18,r0
L_8cb154:
	mov_s r0,blink
L_8cb156:
	mov_s r2,0x100710c
L_8cb15c:
	mov_s r1,0x146e
L_8cb162:
	bl.d L_8c82c0
L_8cb166:
	mov r3,0x1d6
	.global L_8cb16a
L_8cb16a:
	asl r15,r18,0x3
L_8cb16e:
	add1_s r15,r15,r15
L_8cb170:
	add r19,r13,0x4
L_8cb174:
	add r14,r19,r15
L_8cb178:
	ldb_s r1,[r13,0x2]
L_8cb17a:
	extb r0,r18
L_8cb17e:
	cmp_s r1,0x1
L_8cb180:
	mov_s r2,0x1
L_8cb182:
	ld r4,[r14, 0x4]
L_8cb186:
	sub_s.ne r2,r2,r2
L_8cb188:
	ld r5,[r14, 0x8]
L_8cb18c:
	ld r6,[r14, 0xc]
L_8cb190:
	ld_s r1,[r14,0x14]
L_8cb192:
	ld r7,[r14, 0x10]
L_8cb196:
	st_s r1,[sp,0x0]
L_8cb198:
	mov_s r1,0x0
L_8cb19a:
	st_s r1,[sp,0x4]
L_8cb19c:
	ldw_s r1,[r13]
L_8cb19e:
	bl.d L_8d1174
L_8cb1a2:
	ld_s r3,[r14]
L_8cb1a4:
	mov_s r2,0x1007990
L_8cb1aa:
	ldw r4,[r13]
L_8cb1ae:
	mov_s r0,0x0
L_8cb1b0:
	ldb r5,[r13, 0x2]
L_8cb1b4:
	mov_s r1,0x2
L_8cb1b6:
	bl.d L_8ee034
L_8cb1ba:
	mov_s r3,r18
L_8cb1bc:
	ld r4,[r14, 0x4]
L_8cb1c0:
	mov_s r2,0x10075bc
L_8cb1c6:
	ld r5,[r14, 0x8]
L_8cb1ca:
	mov_s r0,0x0
L_8cb1cc:
	mov_s r1,0x2
L_8cb1ce:
	bl.d L_8ee034
L_8cb1d2:
	ld_s r3,[r14]
L_8cb1d4:
	mov_s r2,0x10075ec
L_8cb1da:
	ld r4,[r14, 0x10]
L_8cb1de:
	add_s r15,r15,r19
L_8cb1e0:
	ld r5,[r15, 0x14]
L_8cb1e4:
	mov_s r0,0x0
L_8cb1e6:
	mov_s r1,0x2
L_8cb1e8:
	bl.d L_8ee034
L_8cb1ec:
	ld_s r3,[r14,0xc]
	.global L_8cb1ee
L_8cb1ee:
	bl.d L_8cb680
L_8cb1f2:
	mov_s r0,r16
L_8cb1f4:
	brne r0,0x0,L_8cb148
L_8cb1f8:
	mov_s r1,0x0
L_8cb1fa:
	stb r1,[r17]
L_8cb1fe:
	ld r0,[r13, 0xc4]
L_8cb202:
	mov_s r1,r17
L_8cb204:
	mov_s r2,0x0
L_8cb206:
	mov_s r3,0x19a1
L_8cb20c:
	mov r4,0x1
L_8cb210:
	mov_s r5,r2
L_8cb212:
	mov_s r6,r2
L_8cb214:
	bl.d L_8e0460
L_8cb218:
	mov_s r7,r2
L_8cb21a:
	b.d L_8c030c
L_8cb21e:
	add_s sp,sp,0xc
