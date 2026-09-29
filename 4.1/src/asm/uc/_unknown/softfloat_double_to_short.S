/* softfloat_double_to_short @ 0x9210e4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_build_schedule_tables, softfloat_double_to_short_b
 */
	.section .text.softfloat_double_to_short,"ax",@progbits
	.global softfloat_double_to_short
softfloat_double_to_short:
	.global L_9210e4
L_9210e4:
	not r2,0x0
L_9210e8:
	lsr r2,r2
L_9210ec:
	mov r4,0xa
	.global L_9210f0
L_9210f0:
	asl.f r12,r1
L_9210f4:
	add.cs r2,r2,0x1
L_9210f8:
	lsr r3,r12,0x15
L_9210fc:
	cmp r3,0x7ff
L_921100:
	beq.d L_921148
L_921104:
	bmsk.f r1,r1,0x14
L_921108:
	rsub.f r3,r3,0x413
L_92110c:
	bmi.d L_921126
L_921110:
	bset_s r1,r1,0x14
L_921112:
	cmp_s r3,0x1f
L_921114:
	lsr r0,r1,r3
L_921118:
	mov.gt r0,0x0
L_92111c:
	btst r2,0x0
L_921120:
	j_s.d [blink]
L_921122:
	rsub.eq r0,r0,0x0
	.global L_921126
L_921126:
	rsub r3,r3,0x0
L_92112a:
	cmp_s r3,r4
L_92112c:
	rsub r12,r3,0x20
L_921130:
	lsr r0,r0,r12
L_921134:
	asl r1,r1,r3
L_921138:
	or_s r0,r0,r1
L_92113a:
	mov.gt r0,r2
L_92113e:
	btst.le r2,0x0
L_921142:
	j_s.d [blink]
L_921144:
	rsub.eq r0,r0,0x0
	.global L_921148
L_921148:
	cmp.eq r0,0x0
L_92114c:
	mov_s r0,r2
L_92114e:
	btst.ne r0,0x0
L_921152:
	j_s.d [blink]
L_921154:
	add.ne r0,r0,0x1
