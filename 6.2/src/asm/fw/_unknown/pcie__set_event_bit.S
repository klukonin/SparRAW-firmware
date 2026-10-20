/* pcie__set_event_bit @ 0x8d1a98, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down_notif, pcie__set_event_bit_0_fw_ready, pcie__set_event_bit_19_sysassert, pcie__set_event_bit_1a_txq, pcie__set_event_bit_1b_txq
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_pcie_exit_l1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__set_event_bit
pcie__set_event_bit:
	.global L_8d1a98
L_8d1a98:
	push_s blink
L_8d1a9a:
	push_s r13
L_8d1a9c:
	mov_s r13,r0
L_8d1a9e:
	bl.d L_8d12ac
L_8d1aa2:
	mov_s r0,0x1
L_8d1aa4:
	mov_s r1,0x0
L_8d1aa6:
	bset r1,r1,r13
L_8d1aaa:
	mov_s r0,0x882680
L_8d1ab0:
	st_s r1,[r0,0x30]
L_8d1ab2:
	sync
L_8d1ab6:
	bl.d L_8d12ac
L_8d1aba:
	mov_s r0,0x0
L_8d1abc:
	b L_8c025c
