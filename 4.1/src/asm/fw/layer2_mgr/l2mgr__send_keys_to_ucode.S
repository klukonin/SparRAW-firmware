/* l2mgr__send_keys_to_ucode @ 0x8ed73c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SET_KEYS API is sent to UCODE with the following GTK
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, install_key_index_stub, log_hexdump, mid_list__by_mid
 */
	.section .text.l2mgr__send_keys_to_ucode,"ax",@progbits
	.global l2mgr__send_keys_to_ucode
l2mgr__send_keys_to_ucode:
L_8ed73c:
	add_s sp,sp,0x8
	.global fwlog_SET_KEYS_API_is_sent_to_UCODE_with_the_f
fwlog_SET_KEYS_API_is_sent_to_UCODE_with_the_f:
L_8ed73e:
	nop_s
L_8ed740:
	push_s blink
L_8ed742:
	bl.d L_8ca1b0
L_8ed746:
	push_s r13
L_8ed748:
	mov_s r13,r0
L_8ed74a:
	add r13,r13,0x2cc
L_8ed74e:
	mov_s r2,0x100d6b8
L_8ed754:
	mov_s r0,0x0
L_8ed756:
	bl.d L_8edfb0
L_8ed75a:
	mov_s r1,0x2
L_8ed75c:
	mov_s r0,r13
L_8ed75e:
	bl.d L_8c7f90
L_8ed762:
	mov_s r1,0x10
L_8ed764:
	ldb_s r3,[r13,0x10]
L_8ed766:
	mov_s r0,0x8
L_8ed768:
	mov_s r1,0x4
L_8ed76a:
	mov_s r2,r13
L_8ed76c:
	bl.d L_8e9440
L_8ed770:
	mov r4,0x0
L_8ed774:
	b L_8c033c
