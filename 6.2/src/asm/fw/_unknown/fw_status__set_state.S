/* fw_status__set_state @ 0x8e8634, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main, fw_sysassert_fatal, l2_mgr__connect, l2mgr__data_port_open_and_keys, mlme_sm__association_done, mlme_sm__disconnect_ev_handle
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_status__set_state
fw_status__set_state:
	.global L_8e8634
L_8e8634:
	mov_s r1,0x880a3c
L_8e863a:
	j_s.d [blink]
L_8e863c:
	st_s r0,[r1,0x8]
L_8e863e:
	nop_s
