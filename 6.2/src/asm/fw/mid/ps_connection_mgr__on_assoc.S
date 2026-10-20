/* ps_connection_mgr__on_assoc @ 0x8c3d50, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_NONASSOC_SM__ps_reenter_done
 * Зовёт сам: PS_CONNECTION__assoc_ntf, __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__by_cid, fw_sysassert_fatal
 * Глобалы (через gp): 0x800274, 0x80043c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_connection_mgr__on_assoc
ps_connection_mgr__on_assoc:
	.global L_8c3d50
L_8c3d50:
	push_s blink
L_8c3d52:
	bl L_8c01e4
L_8c3d56:
	bl.d L_8cbffc
L_8c3d5a:
	mov_s r13,r0
L_8c3d5c:
	mov.f r14,r0
L_8c3d60:
	beq_s L_8c3d80
	.global L_8c3d62
L_8c3d62:
	ld_s r1,[r14,0x18]
L_8c3d64:
	ld_s r1,[r1,0x50]
L_8c3d66:
	mov_s r0,0x0
L_8c3d68:
	cmp_s r1,0x2
L_8c3d6a:
	cmp.ne r1,0x3
L_8c3d6e:
	mov.eq r0,0x1
L_8c3d72:
	extb.f 0x0,r0
L_8c3d76:
	bne_s L_8c3d8e
L_8c3d78:
	ld_s r0,[gp,0x2b8]
L_8c3d7a:
	breq_s r0,0,L_8c3d8e
L_8c3d7c:
	mov_s r2,0x1
L_8c3d7e:
	b_s L_8c3d90
	.global L_8c3d80
L_8c3d80:
	mov_s r0,blink
L_8c3d82:
	mov_s r1,0x1428
L_8c3d88:
	bl L_8c9b28
L_8c3d8c:
	b_s L_8c3d62
	.global L_8c3d8e
L_8c3d8e:
	mov_s r2,0x0
	.global L_8c3d90
L_8c3d90:
	ld_s r0,[gp,0xf0]
L_8c3d92:
	mul64 r13,0x88
L_8c3d96:
	bset r0,r0,r13
L_8c3d9a:
	st.as r0,[gp,0x3c]
L_8c3d9e:
	add r0,mlo,0x803db0
L_8c3da6:
	bl.d L_8c3cd8
L_8c3daa:
	mov_s r1,r14
L_8c3dac:
	b L_8c0254
