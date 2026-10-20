/* bf__flow_exit @ 0x921c50, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_responder_flow_enter, txss_resp__flow
 * Зовёт сам: __ld_r13_to_r13_ret, bf__pause_sta_tx, bf_pending__set_bit, bi_tx__check_idle_and_start_uc, internal_tx__clear_pending_bit, rs_abort, sta_link__byte_by_index
 * Глобалы (через gp): 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__flow_exit
bf__flow_exit:
	.global L_921c50
L_921c50:
	push_s blink
L_921c52:
	push_s r13
L_921c54:
	bl.d L_9300c0
L_921c58:
	mov_s r13,r0
L_921c5a:
	brne_s r0,0,L_921c80
L_921c5c:
	asl_s r0,r13,0x2
L_921c5e:
	add2_s r0,r0,r0
L_921c60:
	mov_s r1,0x857e49
L_921c66:
	ldb_s r0,[r1,r0]
L_921c68:
	bic r0,r0,-0xc0
L_921c6c:
	sub.f r0,r0,0x0
L_921c70:
	mov.ne r0,0x1
L_921c74:
	extb.f 0x0,r0
L_921c78:
	bl.ne.d L_92fb80
L_921c7c:
	mov.ne r0,r13
	.global L_921c80
L_921c80:
	bl.d L_92bd70
L_921c84:
	mov_s r0,0x3
L_921c86:
	mov_s r0,0x3
L_921c88:
	bl.d L_92ba54
L_921c8c:
	mov_s r1,r13
L_921c8e:
	bl.d L_93696c
L_921c92:
	mov_s r0,0x2
L_921c94:
	bl.d L_9216f8
L_921c98:
	mov_s r0,0x1
L_921c9a:
	mov_s r0,0x0
L_921c9c:
	st.as r0,[gp,0x33]
L_921ca0:
	b.d L_9202ac
L_921ca4:
	st.as r0,[gp,0x34]
