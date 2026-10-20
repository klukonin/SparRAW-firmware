/* ucode_cmd_0x41_handler @ 0x93a970, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_umac_if_long_range_cmd_handler Long Range is now enabled
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: arc_protect_addr_uc, uc_log__emit_snapshot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x41_handler
ucode_cmd_0x41_handler:
	.global L_93a970
L_93a970:
	push_s blink
L_93a972:
	mov_s r1,0x10015e0
L_93a978:
	bl.d L_92d13c
L_93a97c:
	mov_s r0,0x20
L_93a97e:
	mov_s r0,0x857280
L_93a984:
	ldb_s r0,[r0,0xe]
L_93a986:
	mov_s r1,0x1
L_93a988:
	cmp_s r0,0x0
L_93a98a:
	sub.le r1,r1,r1
L_93a98e:
	mov_s r0,0x2
L_93a990:
	add3_s r0,r0,r1
L_93a992:
	stw.as r0,[gp,-0x10]
L_93a996:
	stw.as r0,[gp,-0xf]
L_93a99a:
	mov_s r1,0x848000
L_93a9a0:
	mov_s r2,0x7fff
L_93a9a6:
	bl.d L_920fb4
L_93a9aa:
	mov_s r0,0x0
L_93a9ac:
	pop_s blink
L_93a9ae:
	j_s [blink]
