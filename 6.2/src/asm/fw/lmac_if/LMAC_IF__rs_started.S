/* LMAC_IF__rs_started @ 0x8dbc6c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LMAC_IF::rs_started - Host - IGNORE
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: conn_mgr__by_cid, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global LMAC_IF__rs_started
LMAC_IF__rs_started:
	.global L_8dbc6c
L_8dbc6c:
	push_s blink
L_8dbc6e:
	bl.d L_8cbffc
L_8dbc72:
	ld_s r0,[r0]
L_8dbc74:
	breq_s r0,0,L_8dbc84
L_8dbc76:
	mov_s r1,0x10041ac
L_8dbc7c:
	bl.d L_8dcba8
L_8dbc80:
	mov_s r0,0x20
L_8dbc82:
	b_s L_8dbc8e
	.global L_8dbc84
L_8dbc84:
	mov_s r0,blink
L_8dbc86:
	mov_s r1,0xca
L_8dbc88:
	bl.d L_8c9b28
L_8dbc8c:
	bset_s r1,r1,0xc
	.global L_8dbc8e
L_8dbc8e:
	pop_s blink
L_8dbc90:
	j_s [blink]
L_8dbc92:
	nop_s
