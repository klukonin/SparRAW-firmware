/* power_mngr__read_g800380 @ 0x8cc1fc, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, assert__restore_hw_for_dump, deep_sleep_enter, deep_sleep_exit
 * Зовёт сам: __ld_r13_to_r13_ret, fw_lshr64, mac_read_tsf64, u_schd__now
 * Глобалы (через gp): 0x800380
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__read_g800380
power_mngr__read_g800380:
	.global L_8cc1fc
L_8cc1fc:
	j_s.d [blink]
L_8cc1fe:
	ld_s r0,[gp,0x1fc]
L_8cc200:
	sub_s sp,sp,0x4
L_8cc202:
	and.f 0x0,r1,0xfff00000
L_8cc20a:
	mov_s r0,0x1
L_8cc20c:
	beq_s L_8cc220
L_8cc20e:
	ldb_s r3,[r2,0x4]
L_8cc210:
	mov_s r0,0x0
L_8cc212:
	b_s L_8cc21c
	.global L_8cc214
L_8cc214:
	sub_s r1,r3,0x1
L_8cc216:
	and_s r3,r3,r1
L_8cc218:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cc21a:
	extw_s r0,r0
	.global L_8cc21c
L_8cc21c:
	brne_s r3,0,L_8cc214
L_8cc21e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8cc220
L_8cc220:
	st_s r0,[r2,0x8]
L_8cc222:
	j_s.d [blink]
L_8cc224:
	add_s sp,sp,0x4
L_8cc226:
	nop_s
L_8cc228:
	push_s blink
L_8cc22a:
	push_s r13
L_8cc22c:
	sub_s sp,sp,0x10
L_8cc22e:
	mov_s r13,r1
L_8cc230:
	mov_s r1,sp
L_8cc232:
	mov_s r0,0x0
L_8cc234:
	bl.d L_8e9900
L_8cc238:
	mov_s r2,r0
L_8cc23a:
	ld_s r1,[sp,0x4]
L_8cc23c:
	ld_s r0,[sp,0x0]
L_8cc23e:
	bl.d L_8c0430
L_8cc242:
	mov_s r2,0x4
L_8cc244:
	bl.d L_8e9524
L_8cc248:
	sub_s r13,r13,r0
L_8cc24a:
	add_s r0,r0,r13
L_8cc24c:
	b.d L_8c025c
L_8cc250:
	add_s sp,sp,0x10
L_8cc252:
	nop_s
