/* find_sm__dband_bcon_in_search @ 0x8e9e2c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND_SM:: dband beacon handle in SEARCH (%d) !
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, find_main_sm__bcon, fw_log__emit1
 */
	.section .text.find_sm__dband_bcon_in_search,"ax",@progbits
	.global find_sm__dband_bcon_in_search
find_sm__dband_bcon_in_search:
L_8e9e2c:
	/* b_s 0x008e9dba */
	.byte 0xc7,0xf1
	.global fwlog_FIND_SM_dband_beacon_handle_in_SEARCH_d
fwlog_FIND_SM_dband_beacon_handle_in_SEARCH_d:
L_8e9e2e:
	nop_s
L_8e9e30:
	push_s blink
L_8e9e32:
	bl L_8c02c0
L_8e9e36:
	mov_s r15,r0
L_8e9e38:
	mov_s r14,r1
L_8e9e3a:
	mov_s r13,r2
L_8e9e3c:
	mov_s r2,0x10147d0
L_8e9e42:
	mov_s r0,0xc
L_8e9e44:
	mov_s r1,0x2
L_8e9e46:
	bl.d L_8edfcc
L_8e9e4a:
	mov_s r3,r13
L_8e9e4c:
	cmp_s r13,0x2
L_8e9e4e:
	mov.eq r0,r15
L_8e9e52:
	mov.eq r1,r14
L_8e9e56:
	bl.eq.d L_8e9d48
L_8e9e5a:
	mov.eq r2,r13
L_8e9e5e:
	.byte 0xd1,0x04
