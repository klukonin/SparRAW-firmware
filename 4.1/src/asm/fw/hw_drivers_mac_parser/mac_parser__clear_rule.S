/* mac_parser__clear_rule @ 0x8dba18, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac_parser.c
 * Зовут его: conn__teardown_mac_rules, l2mgr__data_port_open, vring__on_macq_delete_ntf
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s0_w4, bf_w_s8_w5, fw_sysassert_fatal, mac_parser__write_rule_slot
 */
	.section .text.mac_parser__clear_rule,"ax",@progbits
	.global mac_parser__clear_rule
mac_parser__clear_rule:
	.global L_8dba18
L_8dba18:
	push_s blink
L_8dba1a:
	bl L_8c02bc
L_8dba1e:
	sub_s sp,sp,0x4
L_8dba20:
	mov_s r16,r0
L_8dba22:
	mov_s r13,r1
L_8dba24:
	mov_s r1,0x1f
L_8dba26:
	mov_s r0,sp
L_8dba28:
	bl.d L_8e8564
L_8dba2c:
	cmp_s r13,0x8
L_8dba2e:
	mov_s r1,0x0
L_8dba30:
	bl L_8e8348
L_8dba34:
	ld_s r0,[sp,0x0]
L_8dba36:
	bclr_s r0,r0,0x4
L_8dba38:
	st_s r0,[sp,0x0]
L_8dba3a:
	bhs_s L_8dba4c
	.global L_8dba3c
L_8dba3c:
	mov_s r0,sp
L_8dba3e:
	mov_s r1,r16
L_8dba40:
	bl.d L_8db61c
L_8dba44:
	mov_s r2,r13
L_8dba46:
	b.d L_8c0324
L_8dba4a:
	add_s sp,sp,0x4
	.global L_8dba4c
L_8dba4c:
	mov_s r0,blink
L_8dba4e:
	mov_s r2,0x1019b0c
L_8dba54:
	mov_s r1,0x14
L_8dba56:
	bset_s r1,r1,0xc
L_8dba58:
	bl.d L_8c82c0
L_8dba5c:
	mov r3,0x3f4
L_8dba60:
	b_s L_8dba3c
L_8dba62:
	nop_s
