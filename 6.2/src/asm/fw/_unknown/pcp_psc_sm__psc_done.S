/* pcp_psc_sm__psc_done @ 0x8e1910, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::psc_done. dpm: %d, success: %d
 * Зовёт сам: PS_CONNECTION__psc_complete, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, pcp_psc_sm__m_psc_resp_tx_wb_timeout_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_psc_sm__psc_done
pcp_psc_sm__psc_done:
	.global L_8e1910
L_8e1910:
	push_s blink
L_8e1912:
	bl L_8c01e4
L_8e1916:
	mov_s r13,r0
L_8e1918:
	mov_s r14,r1
L_8e191a:
	ldb_s r2,[r13,0x1c]
L_8e191c:
	mov_s r1,0x1002b7c
L_8e1922:
	mov_s r0,0x2e
L_8e1924:
	bl.d L_8dcc80
L_8e1928:
	mov_s r3,r14
L_8e192a:
	bl.d L_8c69e8
L_8e192e:
	mov_s r0,r13
L_8e1930:
	ldb_s r0,[r13,0x1c]
L_8e1932:
	add r3,r13,0x14
L_8e1936:
	sub.f r2,r0,0x0
L_8e193a:
	ld_s r0,[r13,0x10]
L_8e193c:
	mov.ne r2,0x1
L_8e1940:
	bl.d L_8e172c
L_8e1944:
	mov_s r1,r14
L_8e1946:
	b L_8c0254
L_8e194a:
	nop_s
