/* l2_task__report_error_bits @ 0x92cdd8, 392 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_task__entry
 * Зовёт сам: uc_sysassert
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l2_task__report_error_bits
l2_task__report_error_bits:
	.global L_92cdd8
L_92cdd8:
	ld_s r0,[gp,0xd0]
L_92cdda:
	btst_s r0,0x0
L_92cddc:
	mov.ne r0,blink
L_92cde0:
	mov.ne r1,0x3
L_92cde4:
	asl.ne r1,r1,0xd
L_92cde8:
	bne_s L_92cf5a
L_92cdea:
	btst_s r0,0x1
L_92cdec:
	mov.ne r1,0x6001
L_92cdf4:
	mov.ne r0,blink
L_92cdf8:
	bne_s L_92cf5a
L_92cdfa:
	btst_s r0,0x2
L_92cdfc:
	mov.ne r1,0x6002
L_92ce04:
	mov.ne r0,blink
L_92ce08:
	bne_s L_92cf5a
L_92ce0a:
	btst_s r0,0x3
L_92ce0c:
	mov.ne r1,0x6003
L_92ce14:
	mov.ne r0,blink
L_92ce18:
	bne_s L_92cf5a
L_92ce1a:
	btst_s r0,0x5
L_92ce1c:
	mov.ne r1,0x6005
L_92ce24:
	mov.ne r0,blink
L_92ce28:
	bne_s L_92cf5a
L_92ce2a:
	btst_s r0,0x7
L_92ce2c:
	mov.ne r1,0x6007
L_92ce34:
	mov.ne r0,blink
L_92ce38:
	bne_s L_92cf5a
L_92ce3a:
	btst_s r0,0x9
L_92ce3c:
	mov.ne r1,0x6009
L_92ce44:
	mov.ne r0,blink
L_92ce48:
	bne_s L_92cf5a
L_92ce4a:
	btst_s r0,0xa
L_92ce4c:
	mov.ne r1,0x6010
L_92ce54:
	mov.ne r0,blink
L_92ce58:
	bne_s L_92cf5a
L_92ce5a:
	btst_s r0,0xb
L_92ce5c:
	mov.ne r1,0x6011
L_92ce64:
	mov.ne r0,blink
L_92ce68:
	bne_s L_92cf5a
L_92ce6a:
	btst_s r0,0xd
L_92ce6c:
	mov.ne r1,0x6013
L_92ce74:
	mov.ne r0,blink
L_92ce78:
	bne_s L_92cf5a
L_92ce7a:
	btst_s r0,0xe
L_92ce7c:
	mov.ne r1,0x6014
L_92ce84:
	mov.ne r0,blink
L_92ce88:
	bne_s L_92cf5a
L_92ce8a:
	btst_s r0,0xf
L_92ce8c:
	mov.ne r1,0x6015
L_92ce94:
	mov.ne r0,blink
L_92ce98:
	bne_s L_92cf5a
L_92ce9a:
	btst_s r0,0x10
L_92ce9c:
	mov.ne r1,0x6016
L_92cea4:
	mov.ne r0,blink
L_92cea8:
	bne_s L_92cf5a
L_92ceaa:
	btst_s r0,0x11
L_92ceac:
	mov.ne r1,0x6017
L_92ceb4:
	mov.ne r0,blink
L_92ceb8:
	bne_s L_92cf5a
L_92ceba:
	btst_s r0,0x12
L_92cebc:
	mov.ne r1,0x6018
L_92cec4:
	mov.ne r0,blink
L_92cec8:
	bne_s L_92cf5a
L_92ceca:
	btst_s r0,0x13
L_92cecc:
	mov.ne r1,0x6019
L_92ced4:
	mov.ne r0,blink
L_92ced8:
	bne_s L_92cf5a
L_92ceda:
	btst_s r0,0x14
L_92cedc:
	mov.ne r1,0x6020
L_92cee4:
	mov.ne r0,blink
L_92cee8:
	bne_s L_92cf5a
L_92ceea:
	btst_s r0,0x15
L_92ceec:
	mov.ne r1,0x6021
L_92cef4:
	mov.ne r0,blink
L_92cef8:
	bne_s L_92cf5a
L_92cefa:
	btst_s r0,0x16
L_92cefc:
	mov.ne r1,0x6022
L_92cf04:
	mov.ne r0,blink
L_92cf08:
	bne_s L_92cf5a
L_92cf0a:
	btst_s r0,0x17
L_92cf0c:
	mov.ne r1,0x6023
L_92cf14:
	mov.ne r0,blink
L_92cf18:
	bne_s L_92cf5a
L_92cf1a:
	btst_s r0,0x1a
L_92cf1c:
	mov.ne r1,0x6026
L_92cf24:
	mov.ne r0,blink
L_92cf28:
	bne_s L_92cf5a
L_92cf2a:
	btst_s r0,0x1b
L_92cf2c:
	mov.ne r1,0x6027
L_92cf34:
	mov.ne r0,blink
L_92cf38:
	bne_s L_92cf5a
L_92cf3a:
	btst_s r0,0x1c
L_92cf3c:
	mov.ne r1,0x6028
L_92cf44:
	mov.ne r0,blink
L_92cf48:
	bne_s L_92cf5a
L_92cf4a:
	btst_s r0,0x1d
L_92cf4c:
	mov_s r0,blink
L_92cf4e:
	mov.ne r1,0x6029
L_92cf56:
	mov.eq r1,0x26
	.global L_92cf5a
L_92cf5a:
	b L_926618
L_92cf5e:
	nop_s
